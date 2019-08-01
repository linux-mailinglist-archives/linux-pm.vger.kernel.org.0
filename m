Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 315507E175
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2019 19:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387879AbfHARxW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Aug 2019 13:53:22 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17490 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbfHARxV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Aug 2019 13:53:21 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d4327110001>; Thu, 01 Aug 2019 10:53:21 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 01 Aug 2019 10:53:20 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 01 Aug 2019 10:53:20 -0700
Received: from [10.110.103.107] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 1 Aug
 2019 17:53:20 +0000
Subject: Re: [PATCH v7 10/20] clk: tegra: clk-dfll: Add suspend and resume
 support
To:     Dmitry Osipenko <digetx@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Jui Chang Kuo <jckuo@nvidia.com>,
        Joseph Lo <josephl@nvidia.com>, Timo Alho <talho@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Sandipan Patra <spatra@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
References: <1564607463-28802-1-git-send-email-skomatineni@nvidia.com>
 <1564607463-28802-11-git-send-email-skomatineni@nvidia.com>
 <4400ffef-685f-b9e6-3b07-4790f851282c@gmail.com>
 <501a9d0e-ce78-9b35-642d-dff7f9223926@gmail.com>
 <BYAPR12MB3398C388471BC5811614C8FEC2DE0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <31990250-e237-ddb9-ce71-29b7c2302fc3@gmail.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <0dbc6d22-486c-8b45-bae1-b5ce4efdc370@nvidia.com>
Date:   Thu, 1 Aug 2019 10:53:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <31990250-e237-ddb9-ce71-29b7c2302fc3@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1564682001; bh=7+1PFHicTud3X5V5EB7upBR1QSBsHrLd4rrZFOsAsuU=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=kc/HiXp+yv/RKIiD5ZYFWDIGn3g8OcPGCCPnVUXbgrYM5NgD33I+ceTh+gl93GUEr
         1dykTeQ2sCIRLzcqRAHytJTZFo9y/J1K8xEffgEF4CUtblfIywVqrTeymPuodiLK4M
         d1Dv40h3CECRQqYG9xmy2erXVSX1tHG8NsEOqcN0c9xqu2fJqReWvb+91ALTVAhV3i
         EcbhiNyvSM01eKtTfHRpp5DXDK6t3nr8gG3Jyhhi5OTetVPncgbIghYuPhSBTARrM9
         OPpGuelOP8c7Lt3VUQ9LTSpLx03v1Xn+0XY7P6jtk7fXsXfSTfBTbkETHsLUly9QRI
         c7W9Y4/Aeis1w==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 8/1/19 10:10 AM, Dmitry Osipenko wrote:
> 01.08.2019 19:10, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> I didn=E2=80=99t updated any patches. This is still same v7 just resent =
with
>> CPUFreq maintainers in CC as I missed to add them earlier.
> There are now two different threads for the same patches, which is not
> very good. When I said that CPUFreq maintainers should be CC'ed, I
> didn't mean to resend it all, sorry for not being clear about it. You
> should've wait for more comments to the original patches and then make a
> v8. I suggest to do the same in the current situation as well, please
> address all the current comments and wait for 1-2 days, then make a v8.

Thought version bump is only when changes were made. Got it now.

Thanks Dmitry. Sure, will give some time for all feedbacks before=20
sending V8.

