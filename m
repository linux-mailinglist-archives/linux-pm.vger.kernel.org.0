Return-Path: <linux-pm+bounces-1258-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5B3816196
	for <lists+linux-pm@lfdr.de>; Sun, 17 Dec 2023 19:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDE341F21532
	for <lists+linux-pm@lfdr.de>; Sun, 17 Dec 2023 18:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A1847A70;
	Sun, 17 Dec 2023 18:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="JkOIe82K"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C3847A4B
	for <linux-pm@vger.kernel.org>; Sun, 17 Dec 2023 18:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33638e7f71aso1190391f8f.1
        for <linux-pm@vger.kernel.org>; Sun, 17 Dec 2023 10:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1702837377; x=1703442177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Yv2ZZ62CekfjBHEFQHgv0SBWTCKY1ilmODV39lFe4g=;
        b=JkOIe82K8IdiEL3nSs364p2VmE6R0HTLn7GT/kVgVRtr1QY9y8Wsprtk+fa4PpjyhU
         A/XbYCbsp5xhTfumWyQ4B0NeeJmJ+gggezX6Yv3zJfg0O7ZMpBELtfm7fppPvwXEZov9
         drdxjflknAZE43OJq4aATHJnv64Xy06KRE+c5mKmd+s2HzJyjZNk3U+vv8ebpVZLTW2z
         glnvpKeZWYhCIRxyBExfqyjTaaukEh3rHC8zUN4eh1XlS+iYB2Hs+zDwnwQcGxnkv+vf
         u8fQ0aDiFArt/MgBo7/K8w/PHWrGlWda4UMV6AqJRcBsH2Ls+/ptu+/CEQkREvhpaRN+
         81pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702837377; x=1703442177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Yv2ZZ62CekfjBHEFQHgv0SBWTCKY1ilmODV39lFe4g=;
        b=hAEMBP/GQljYBwKhsjmfmW9tUSlFVxexfi8NApYGc8LRrvQ+R7rdIZDqHN3Wdl4h+y
         GgTXeF7gm3PMccZCiyv1uIC91ZZu85+vNPgoESu/8Dn08pK6L5j3iaEWUUUJWCsmhXbS
         WsDhQ9H0h/LtNTzg10QfwhnQ/UenaWYcFKhZaTmuQUgbHNuM4S3zJk56fGjoQOCNruEW
         RUXpQk0rtflBuwjYBxG+B6K6VAhLySTTo/GEZ1wfpC7WVbLCcFduVb634uB969+wGnBH
         32OsU4RaASdesVMqEUHc3q4C/xQ1/bgB93GRNUaYKIlV/RMyqvTZ5rAm6x4sMiBbo+Od
         MkFA==
X-Gm-Message-State: AOJu0YwTYhwMACGawdaVM7dj1h+Z8E90CCX3N1vs2dBiGjFkJaDrMTrR
	O1Yn6UfStTns+FKKNE9FJSrFtg==
X-Google-Smtp-Source: AGHT+IEzrEMML7X0gSq2pPjMZaHBpN3KD7UdwoKrtGBCWFM6AnUvhTdy2D83WRZfp6KrsKl8qC++Ug==
X-Received: by 2002:a05:6000:790:b0:333:ebe:734c with SMTP id bu16-20020a056000079000b003330ebe734cmr8065298wrb.7.1702837376806;
        Sun, 17 Dec 2023 10:22:56 -0800 (PST)
Received: from airbuntu (host86-135-101-43.range86-135.btcentralplus.com. [86.135.101.43])
        by smtp.gmail.com with ESMTPSA id d7-20020adfef87000000b00336598903e9sm6055927wro.58.2023.12.17.10.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 10:22:56 -0800 (PST)
Date: Sun, 17 Dec 2023 18:22:55 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael@kernel.org, dietmar.eggemann@arm.com, rui.zhang@intel.com,
	amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
	daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
	len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
	wvw@google.com
Subject: Re: [PATCH v5 00/23] Introduce runtime modifiable Energy Model
Message-ID: <20231217182255.mgrpgpu6ojjg62jp@airbuntu>
References: <20231129110853.94344-1-lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231129110853.94344-1-lukasz.luba@arm.com>

Hi Lukasz

On 11/29/23 11:08, Lukasz Luba wrote:
> Hi all,
> 
> This patch set adds a new feature which allows to modify Energy Model (EM)
> power values at runtime. It will allow to better reflect power model of
> a recent SoCs and silicon. Different characteristics of the power usage
> can be leveraged and thus better decisions made during task placement in EAS.
> 
> It's part of feature set know as Dynamic Energy Model. It has been presented
> and discussed recently at OSPM2023 [3]. This patch set implements the 1st
> improvement for the EM.

Thanks. The problem of EM accuracy has been observed in the field and would be
nice to have a mainline solution for it. We carry our own out-of-tree change to
enable modifying the EM.

> 
> The concepts:
> 1. The CPU power usage can vary due to the workload that it's running or due
> to the temperature of the SoC. The same workload can use more power when the
> temperature of the silicon has increased (e.g. due to hot GPU or ISP).
> In such situation the EM can be adjusted and reflect the fact of increased
> power usage. That power increase is due to static power
> (sometimes called simply: leakage). The CPUs in recent SoCs are different.
> We have heterogeneous SoCs with 3 (or even 4) different microarchitectures.
> They are also built differently with High Performance (HP) cells or
> Low Power (LP) cells. They are affected by the temperature increase
> differently: HP cells have bigger leakage. The SW model can leverage that
> knowledge.

One thing I'm not sure about is that in practice temperature of the SoC can
vary a lot in a short period of time. What is the expectation here? I can see
this useful in practice only if we average it over a window of time. Following
it will be really hard. Big variations can happen in few ms scales.

Driver interface for this part makes sense; as thermal framework will likely to
know how feed things back to EM table, if necessary.

> 
> 2. It is also possible to change the EM to better reflect the currently
> running workload. Usually the EM is derived from some average power values
> taken from experiments with benchmark (e.g. Dhrystone). The model derived
> from such scenario might not represent properly the workloads usually running
> on the device. Therefore, runtime modification of the EM allows to switch to
> a different model, when there is a need.

I didn't get how the new performance field is supposed to be controlled and
modified by users. A driver interface doesn't seem suitable as there's no
subsystem that knows the characteristic of the workload except userspace. In
Android we do have contextual info about what the current top-app to enable
modifying the capacities to match its characteristics.

> 
> 3. The EM can be adjusted after boot, when all the modules are loaded and
> more information about the SoC is available e.g. chip binning. This would help
> to better reflect the silicon characteristics. Thus, this EM modification
> API allows it now. It wasn't possible in the past and the EM had to be
> 'set in stone'.
> 
> More detailed explanation and background can be found in presentations
> during LPC2022 [1][2] or in the documentation patches.
> 
> Some test results.
> The EM can be updated to fit better the workload type. In the case below the EM
> has been updated for the Jankbench test on Pixel6 (running v5.18 w/ mainline backports
> for the scheduler bits). The Jankbench was run 10 times for those two configurations,
> to get more reliable data.
> 
> 1. Janky frames percentage
> +--------+-----------------+---------------------+-------+-----------+
> | metric |    variable     |       kernel        | value | perc_diff |
> +--------+-----------------+---------------------+-------+-----------+
> | gmean  | jank_percentage | EM_default          |  2.0  |   0.0%    |
> | gmean  | jank_percentage | EM_modified_runtime |  1.3  |  -35.33%  |
> +--------+-----------------+---------------------+-------+-----------+
> 
> 2. Avg frame render time duration
> +--------+---------------------+---------------------+-------+-----------+
> | metric |      variable       |       kernel        | value | perc_diff |
> +--------+---------------------+---------------------+-------+-----------+
> | gmean  | mean_frame_duration | EM_default          | 10.5  |   0.0%    |
> | gmean  | mean_frame_duration | EM_modified_runtime |  9.6  |  -8.52%   |
> +--------+---------------------+---------------------+-------+-----------+
> 
> 3. Max frame render time duration
> +--------+--------------------+---------------------+-------+-----------+
> | metric |      variable      |       kernel        | value | perc_diff |
> +--------+--------------------+---------------------+-------+-----------+
> | gmean  | max_frame_duration | EM_default          | 251.6 |   0.0%    |
> | gmean  | max_frame_duration | EM_modified_runtime | 115.5 |  -54.09%  |
> +--------+--------------------+---------------------+-------+-----------+
> 
> 4. OS overutilized state percentage (when EAS is not working)
> +--------------+---------------------+------+------------+------------+
> |    metric    |       wa_path       | time | total_time | percentage |
> +--------------+---------------------+------+------------+------------+
> | overutilized | EM_default          | 1.65 |   253.38   |    0.65    |
> | overutilized | EM_modified_runtime | 1.4  |   277.5    |    0.51    |
> +--------------+---------------------+------+------------+------------+
> 
> 5. All CPUs (Little+Mid+Big) power values in mW
> +------------+--------+---------------------+-------+-----------+
> |  channel   | metric |       kernel        | value | perc_diff |
> +------------+--------+---------------------+-------+-----------+
> |    CPU     | gmean  | EM_default          | 142.1 |   0.0%    |
> |    CPU     | gmean  | EM_modified_runtime | 131.8 |  -7.27%   |
> +------------+--------+---------------------+-------+-----------+

How did you modify the EM here? Did you change both performance and power
fields? How did you calculate the new ones?

Did you try to simulate any heating effect during the run if you're taking
temperature into account to modify the power? What was the variation like and
at what rate was the EM being updated in this case? I think Jankbench in
general wouldn't stress the SoC enough.

It'd be insightful to look at frequency residencies between the two runs and
power breakdown for each cluster if you have access to them. No worries if not!

My brain started to fail me somewhere around patch 15. I'll have another look
some time later in the week but generally looks good to me. If I have any
worries it is about how it can be used with the provided interfaces. Especially
expectations about managing fast thermal changes at the level you're targeting.


Thanks!

--
Qais Yousef

