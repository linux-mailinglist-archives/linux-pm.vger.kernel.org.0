Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA17511C2D2
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2019 02:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfLLB6m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Dec 2019 20:58:42 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38859 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbfLLB6m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Dec 2019 20:58:42 -0500
Received: by mail-lj1-f196.google.com with SMTP id k8so382231ljh.5;
        Wed, 11 Dec 2019 17:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tIX439an0mvSSKUZP4UoZM6AftaCewaB/Dw94KbRNQw=;
        b=cI6lajdchoiQCB0ZPJFKLDWjbXTKkewcnAA2vt0UpdVGrexxMyMDTsKROrMhQHeN3Q
         mEYQlAG0yFtsx8u4aRBKGMKIvy1+TMeXs11Rwl8sHR68uS3P6hQOy8+rhvetoHQGe9T8
         1MHG1ZwzevLOBtSLxWFhbBimeAth3fVIFTdtR14V1PeZPalL/vXu4Zo7T/gYHQC8TYFZ
         UEvghfhhyuyvsHZPx9Y5VAwUdRqq+LBq1ODPrD6gBB2rI+d1JXqS/rP9nX0OUpmFZGq+
         XDftqxyefM8oLqSSs56ivfUH4y3N7wdT4p5mk4wwyi50oPm3dNkS3eLcObO6C0DyOysA
         HHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tIX439an0mvSSKUZP4UoZM6AftaCewaB/Dw94KbRNQw=;
        b=lFZBZIW/h7khWX2NQYt7S8a45x3G6h/QbK2Pg8qAMYMK08IHLFVQljOsFS+E+XrA0n
         fUt1pZ3F8CgUh/TczX5Y1/PVz0B1DoQndcK/zrT9A9wNECVjUCb+DrTWWWJShrTui7D8
         aeliu33BUji9pEkSFnSWIECTCpHkF+hfS0gI96AJHac9w/MGxStxCWGv2egXc+ohIn8t
         EXLxbfoNWcnZP/9D2DYC7zaHEM1zQq8ylvPqT75qHZxGOnfMppH4WBF4c07dfd5fB+YB
         0v6jrLQCv5LC8nrrZTKPRE0Q9Z+h0izkL63D7+nRHs/Yz4jrKXpJjtdEtIy3Mr74zJEY
         Ydyw==
X-Gm-Message-State: APjAAAUUZRLIpoNA9MpDFjr7oWpB6+xZl6MM4BZcNF453sXkVMcccMmS
        Kh/Xcizg7Amo8OJVkUCo3snKiloT
X-Google-Smtp-Source: APXvYqx4UOyMZoR302qC575ORpINoBpp4YP/1VBKp22kXDTTp1mMbo3doeHAENR3csP22uTGPLfFVA==
X-Received: by 2002:a2e:9b8f:: with SMTP id z15mr4292823lji.20.1576115919796;
        Wed, 11 Dec 2019 17:58:39 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id f11sm2337887lfa.9.2019.12.11.17.58.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 17:58:39 -0800 (PST)
Subject: Re: [PATCH v8 00/19] Consolidate and improve NVIDIA Tegra CPUIDLE
 driver(s)
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191203004116.11771-1-digetx@gmail.com>
 <20191211085120.GX28289@pdeschrijver-desktop.Nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <804e46c7-1c39-926a-6624-924739433638@gmail.com>
Date:   Thu, 12 Dec 2019 04:58:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191211085120.GX28289@pdeschrijver-desktop.Nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

11.12.2019 11:51, Peter De Schrijver пишет:
> On Tue, Dec 03, 2019 at 03:40:57AM +0300, Dmitry Osipenko wrote:
>> Hello,
>>
>> This series does the following:
>>
>>   1. Unifies Tegra20/30/114 drivers into a single driver and moves it out
>>      into common drivers/cpuidle/ directory.
>>
>>   2. Enables CPU cluster power-down idling state on Tegra30.
>>
>> In the end there is a quite nice clean up of the Tegra CPUIDLE drivers
>> and of the Tegra's arch code in general. Please review, thanks!
>>
> 
> Acked-By Peter De Schrijver <pdeschrijver@nvidia.com> for the series.
> 
> Peter.
> 

Thank you very much! Will be awesome if you could take a look at the
cpufreq patches as well [1].

There are also some other older unreviewed clk patches on the list that
I'd want you to take a look. I'll revisit and re-send them soon. Maybe
will add the PLLX LP1 patches [2] into cpufreq series.

[1] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=143592

[2] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=139741
