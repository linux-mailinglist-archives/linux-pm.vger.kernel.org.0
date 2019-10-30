Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF405EA523
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2019 22:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfJ3VFd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 17:05:33 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34869 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfJ3VFc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Oct 2019 17:05:32 -0400
Received: by mail-lf1-f65.google.com with SMTP id y6so2717914lfj.2;
        Wed, 30 Oct 2019 14:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nkaIP1ijgOYFqnsYglfYHdRc24DvX3SU4ZQ7OZUvKUM=;
        b=kptuIiTdPy3kXqZuC8a1zJUJ8GiyvG8oF0rvc9IU9wDZw+29au1yUPtmzXszddcYzd
         M4F3NNfYrb3Asgkjh7UomGi+SEIpSoqBaRfQ5yP1UzeG0KidA3l7IwfTlzX21uhnjMuk
         rn2eO06u9iGMQTcyN6DOFsqGoiLb0QM5pXCYH+xYfKhGRaAeuuXRyhFFcnAYFOVnPvGj
         yDdNlH4ya81pCSv8Rhd9Hnd8oGqeL9ayv/K+HRsVhhlEmkbjqt2E/OkFOWnbRBT8GRw5
         QTxDFDzg0H2a8ZUAYzSawhbOxYCmuDT9YIwgcaIYUxKdIAEadcjyz/jMjo507aDdN7bR
         ZUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nkaIP1ijgOYFqnsYglfYHdRc24DvX3SU4ZQ7OZUvKUM=;
        b=r6uoaekrmWNUaavEBQaBJYsQuKcM+iaAfgY/JZxPkcm33bkgIi3sx2+n5YLcYS5i+p
         M+al8BIZ00LziQHOCNkUANuLPheDGS5japZFVl2fbqcnms3G7HUiTtnQffzVwjwf9hVz
         cuFiXhOWOY295Xla8xLAcKkkTLWTszg7f6jaBH9eR/G/QaM7AZufKj4lqVdfwp80yGg+
         V8+g9sxG3ICT2UBUy6LBJq1B2Ag0RWy7mKW3rZhmToizGUGJj2rFmb8grLYThgbfKnKU
         Yq1Al293Dal6UIx8uswNISv5CanRs1gydS7MB29ZwIl3YmHjaHlyvYWybw5ma3ElItRE
         Od1Q==
X-Gm-Message-State: APjAAAXYLCWv6HTqP61+JRzO6dDAssaRQ1e2f17ulYdTYGiYPheRcbyu
        cLFY1SkNx2jlDHCtvEY2PoaEHW1N
X-Google-Smtp-Source: APXvYqxrX4VoN4tXIb0m+jXClOMlA0A0NLHPTNUipKvKg8IRFWXzcRaxKR2RmNx78kgjKghJZ0AFVQ==
X-Received: by 2002:a19:5e53:: with SMTP id z19mr146580lfi.111.1572469529984;
        Wed, 30 Oct 2019 14:05:29 -0700 (PDT)
Received: from [192.168.2.145] (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.googlemail.com with ESMTPSA id q15sm481394lfb.84.2019.10.30.14.05.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2019 14:05:29 -0700 (PDT)
Subject: Re: [PATCH v2 06/17] dt-bindings: cpufreq: Add binding for NVIDIA
 Tegra20/30
To:     Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191024221416.14197-1-digetx@gmail.com>
 <20191024221416.14197-7-digetx@gmail.com> <20191029214258.GA18586@bogus>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b81fbaac-3566-1153-3c5c-c6b3ba2db522@gmail.com>
Date:   Thu, 31 Oct 2019 00:05:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191029214258.GA18586@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

30.10.2019 00:42, Rob Herring пишет:
> On Fri, 25 Oct 2019 01:14:05 +0300, Dmitry Osipenko wrote:
>> Add device-tree binding that describes CPU frequency-scaling hardware
>> found on NVIDIA Tegra20/30 SoCs.
>>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  .../cpufreq/nvidia,tegra20-cpufreq.txt        | 56 +++++++++++++++++++
>>  1 file changed, 56 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
>>
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 

Thanks!
