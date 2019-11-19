Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7AD71029E5
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2019 17:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbfKSQ4N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Nov 2019 11:56:13 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37318 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728320AbfKSQ4N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Nov 2019 11:56:13 -0500
Received: by mail-lf1-f65.google.com with SMTP id b20so17691489lfp.4;
        Tue, 19 Nov 2019 08:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=giMwmMYCTfwG4t/m7GcZ9wpvpN8uV7OEh8vHMV0l5S0=;
        b=rmUv4RO88MDLOtSHN6/ZZBmKiLjFBYSKFwhCyvhX3/1sXT3xESgFLG8mDpW2oWH9Fl
         /MfigHIV5FK4dGGKcQlfHlByQhnj00/6hvQcYo1wWB7dBUD8eHQMeEwxOEoWmnnVKGSc
         nQJSsYZDKVtWGVfuvbXM6B+41ei9mpONcrBi+fugiqwLgu1MUPi8oAKsectEI8YLv/dI
         kAW37irsEiTAX/lnlI1WTqe4rYtLERlsK4V7V4XtpddzJUX+adAdAvABrH3WAwMjq+6k
         hYJw8Ib3vdKZeQ0RAnz05RAoR7kawTZB6A7zVCgmKR+MzDnAxlanLh+6Q//2fwcmgLZ9
         djdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=giMwmMYCTfwG4t/m7GcZ9wpvpN8uV7OEh8vHMV0l5S0=;
        b=jol/VHYGBFkRRoojYyTzz3/VhRXRO5Ot73HB0yCrhL4CQY9vDJWoK3tx8JLp72BCg+
         xB/0PZ51r3k/5zdPNl93LTRY01g3r2QQ/bEzXU4Qi27Mmm99KOzdN1TNBC7Rx3j21soV
         OUYfjdfCsZ9+uHbwv0mNl/NTRQ8RcDv93PzLn+HfnviX2uB6Ah+dJF/Zw43H5fDfLK44
         nbGWRUgKtZrLeRO7feYc1Y4MgEkyakrl0j/DokErMJZrik73E26XEs1HZ8YqxavJuD5j
         Fr52ykj85IqUfeyF64UgjBPsbNS7TjnPb1crVRV8dBVwW/xLzWRzUpMBgUwVWIYsJglk
         FPrw==
X-Gm-Message-State: APjAAAXCJS3BwVwbv9/vUBGfWv2hYK46JB4TLaBBkT1S9pjEeU6elJSn
        YyQZc0z+ZxHAzKySpbVr+88w4anL
X-Google-Smtp-Source: APXvYqzthkVZ1hMtk0VsW3K9xsqiauD6RdH04NOkFmKx3D6tdSccWVopfg3OX5PNStxfi+4MYkk1mw==
X-Received: by 2002:ac2:5967:: with SMTP id h7mr4671524lfp.119.1574182570172;
        Tue, 19 Nov 2019 08:56:10 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id y5sm10749907lfg.5.2019.11.19.08.56.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2019 08:56:09 -0800 (PST)
Subject: Re: [PATCH v1 08/29] dt-bindings: interconnect: tegra: Add initial
 IDs
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
References: <20191118200247.3567-1-digetx@gmail.com>
 <20191118200247.3567-9-digetx@gmail.com> <20191119062535.GC2462695@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <8cff3af3-42c7-3312-5f98-cd5eb98b7b7a@gmail.com>
Date:   Tue, 19 Nov 2019 19:56:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191119062535.GC2462695@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

19.11.2019 09:25, Thierry Reding пишет:
> On Mon, Nov 18, 2019 at 11:02:26PM +0300, Dmitry Osipenko wrote:
>> Define interconnect IDs for memory controller (MC), external memory
>> controller (EMC), external memory (EMEM) and memory clients of display
>> controllers (DC).
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  include/dt-bindings/interconnect/tegra-icc.h | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>  create mode 100644 include/dt-bindings/interconnect/tegra-icc.h


Hello Thierry,

> There was a bit of discussion regarding this for a recent patch that I
> was working on, see:
> 
> 	http://patchwork.ozlabs.org/project/linux-tegra/list/?series=140318

Thank you very much for the link.

> I'd rather not use an additional set of definitions for this. The memory
> controller already has a set of native IDs for memory clients that I
> think we can reuse for this.

I missed that it's fine to have multiple ICC connections defined
per-path, at quick glance looks like indeed it should be fine to re-use
MC IDs.

> I've only added these client IDs for Tegra194 because that's where we
> need it to actually describe a specific hardware quirk, but I can come
> up with the equivalent for older chips as well.

Older Tegra SoCs have hardware units connected to MC through AHB bus,
like USB for example. These units do not have MC client IDs and there is
no MC ID defined for the AHB bus either, but probably it won't be a
problem to define IDs for them if will be necessary.
