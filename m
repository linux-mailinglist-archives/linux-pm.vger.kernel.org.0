Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1222C0E4A
	for <lists+linux-pm@lfdr.de>; Mon, 23 Nov 2020 16:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731209AbgKWO5H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Nov 2020 09:57:07 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:13479 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729772AbgKWO5G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Nov 2020 09:57:06 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fbbcdc40002>; Mon, 23 Nov 2020 06:57:08 -0800
Received: from [10.26.72.66] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 23 Nov
 2020 14:57:04 +0000
Subject: Re: [RFC] PM Domains: Ensure the provider is resumed first
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Saravana Kannan <saravanak@google.com>
References: <0e00f9ba-571a-23a0-7774-84f893ce6bd5@nvidia.com>
 <CAPDyKFrxKhO0V-uTDLDV6RFQFwhjesE0zfnuBLfYs-n5bNxXtg@mail.gmail.com>
 <35721978-d166-c5d9-06f6-45cec0d835ad@nvidia.com>
 <CAPDyKFoVQ=D96KtFnmjMh6R7=PrCvTLWqUAPAYsRrVOg2dFFTA@mail.gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <d51fd10f-864a-f7ea-4b8b-006351a16a05@nvidia.com>
Date:   Mon, 23 Nov 2020 14:57:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFoVQ=D96KtFnmjMh6R7=PrCvTLWqUAPAYsRrVOg2dFFTA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606143429; bh=ZBmMr6d9no4mjeUSMuUqGJ+blESX06XSSZt5vp2y2dw=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=crIUkPwvOWIEHiLQLydibYfwNHZeUJZRBB6/ZqHv6mlVcEi6ZyDgWHcjfRKuTf9e1
         uqE84BU8KYcudiKdRPYRcbzVzmaMGPuGbSa0WLM0ZjGdoFR/3xuKYshVKNjclsM+4E
         Oh8BI/YJ9Hw8cTsWlFdHVXqBi8Z1/dRkqL/hn10ojEgsCg0C0G6+LF6s296Pi+ztrB
         r9K1v1gyRasq2M7VM0uWAesavMJPc7MoaPvD1jM+LEGKGVmC9rT340qB1E41lkJyP+
         TwSW833u784YlNM3Lj6w9S2D3oXcpKR8ISZFJ7DgCFIi22+WxGxu6BU+FuyY3ZLtA4
         ZfwbSARAx8B1A==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 23/11/2020 14:31, Ulf Hansson wrote:

...

>>> Note that, if there is no device attached to the genpd, the
>>> ->power_on() callback may not be invoked - unless there is a child
>>> domain being powered on.
>>>
>>> From the genpd provider driver point of view - why do you need to
>>> implement system suspend/resume callbacks at all? Do you have some
>>> additional operations to run, besides those executed from the
>>> ->power_on|off() callbacks?
>>
>> The provider in this case is an embedded controller, the BPMP, and it
>> needs to be resumed [0] prior to calling the provider callbacks. I am
>> wondering if any other providers have this requirement?
> 
> It seems like it should be a rather common requirement for a genpd
> provider - at least for those providers that need to run some
> additional operations at system suspend/resume.
> 
> I guess the reason for this problem is that the order of how the
> devices end up in the dpm_list, doesn't fit well for your case.
> Normally, a provider should be registered prior and the consumer, as
> that would probably lead to that the provider becomes resumed first.

Yes it does appear that way. The BPMP (genpd provider) is probed before
the ACONNECT (consumer) but still the order in which they end up in is
not what we want.

> In any case, to make sure the order becomes correct, a device link
> should be created between the genpd domain provider and the consumer
> device. As a matter of fact, this is done "automagically" during boot
> for DT based platforms, see of_link_property() in
> drivers/of/property.c.
> 
> Currently these device links are created with DL_FLAG_SYNC_STATE_ONLY,
> unless the "fw_devlink" kernel command line specifies a different
> option (on == DL_FLAG_AUTOPROBE_CONSUMER). I would try to play with
> that and see how that turns out.

OK, good to know. I will take a look at that. Thanks for the inputs.

Jon

-- 
nvpublic
