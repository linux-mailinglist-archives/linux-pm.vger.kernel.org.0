Return-Path: <linux-pm+bounces-39393-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB13CB1E24
	for <lists+linux-pm@lfdr.de>; Wed, 10 Dec 2025 05:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B0733005095
	for <lists+linux-pm@lfdr.de>; Wed, 10 Dec 2025 04:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8F52D5C83;
	Wed, 10 Dec 2025 04:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q413JXKq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C34A2AD25
	for <linux-pm@vger.kernel.org>; Wed, 10 Dec 2025 04:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765339969; cv=none; b=eQSlvhz08H7byi9nmBLgj/9cPxDoD/7gp4QXiyQh+1y0fu94ngKh2eX7zBvbAFiV3jNDDPgR9FAHpb8aarkX8b6hnwcJZZhhGH/PfZO0RT5Md+AIHYHpOLtunkaOVCC+KRVn4H2+2+57F1WZjeDsh45HJPgarAlM0hukm8m7tn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765339969; c=relaxed/simple;
	bh=I1Cy51DjdrfV1lJORA8twnpGemeJZxTKfGS87+bmmko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppM+mAbIGtAWYTconazAySmFHvscTdvW5wXOUrQdU0EOZI+4crGFCY1DVJrFk6sULN2sopW2gs1+bX2te6uapL9jA96vm58A/b29nrp1IoApf5NZfX0lV3D3rIOtDWe27a5D/ip2Td0dQWfLSUp81XnKw1zZGQIHznsIXW8ELco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q413JXKq; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7bc0cd6a13aso305445b3a.0
        for <linux-pm@vger.kernel.org>; Tue, 09 Dec 2025 20:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765339967; x=1765944767; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=09Naui42twULbY2Duje+MoNln2Zb70ElVw4FzGSkkKQ=;
        b=Q413JXKq09z68ncariLxybGf6k1ohkkYU7CYhU8S5A774N2nBQBZobMC41RIX4ek4I
         RavJbuylStaiT7/3jtQGqH5q9+H+qupUhdI0o5a2IlnXpqwUb60/I78IC7l7TMTEyPiQ
         altAKrzUIg5mamUa/Ese9TdyOq9jCaRIUHvHXobVfLSZklxqb56GLVFt4Yz8T+kIeKMK
         Q1ExNLn3xxZYE4SdHmDiYjzG3itCScX+6Pm5FlFaK3nDxhxfb1veLjdXgofmkQ/k8x5V
         U2im+rOXly+imCR5QlO1ShqgG29IVlNjsyJNdfWg59xk7lVuLJqTba9Sp2AsNHlJHKS4
         w/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765339967; x=1765944767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=09Naui42twULbY2Duje+MoNln2Zb70ElVw4FzGSkkKQ=;
        b=f2KSVnWaqKZOYyo+ZY2zf5YfHM92aycjxEiCB8g5DgUx0ed5ivHBqSe1ZOc91gp0FG
         WwnfGdvXk2NoCLAPTeSzju409z+nN9dKRFCN46Gmfy5Rdxd2DOilvDvVIhhQcnvixR9Z
         9aFnf93EjJYWh8JWsoeJmrN3IbH0ypZN8DvYCnry5s6ulYTSE7x6BTKfWHFyxPIMevk8
         RneIO9kV8NMVAxpkhgGfrTBdeuXV0hhm0H1I4wAMgOaDXQ0sEbMbY5MjJrkuoqyYN0uD
         w/vv4sNtS+gJKv3WeBzZahimieLfPkM8G/sMUXFNAeHSvTog2A5VcckU8pQCnOsFhfnp
         J2Xg==
X-Forwarded-Encrypted: i=1; AJvYcCVMVB43TEAqfIRE69TUiTdg4TqhkpvBDXgnj4jisgw98ezviiUgYByZEgoRhqpQW8r4BgSd0Aal6w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7uD6TE2RF8ztVovy3CoKSa4yD3zr1XrspgNxdX0lUVp2W8DKw
	OT503QlI+oDtkwmi8w92xM13dKuqVbZH7QUmrlFV45Q6dNWsXhO/zsV/HzKJ9V/ibqM=
X-Gm-Gg: ASbGncsElUt1Kv3OMRLgYPEIXL15bcXlNuf36zpo1D1mYWXrn9cLVnU7Gsv7LNTBekf
	Fmhb0DCa/dlYad9t7/+cC2mKji6iN4TzbdtAvHX7eVGPpOhhYJgZV1N/WvvzyBmfqwc54IzTg2r
	NZkiruGIB48+qeFEe0VbjwcQlDKR1cj2/xJYu5kh6z7pw0KjkV5AhxPLlatw5S3hB5mzguwhCHX
	uSgB4gxRVeRQsJ0J32HnPIi380M8/UO0A3G8VwvHDCtmau7CvCYd/fGAKfbuUeg5se6+sd+g/7K
	zg0spRygFdbfzDWIWiHNASeZn6pzi2V3olF+jv7dY2CNWENC+2zlGq4bk2IzN+ODuIcvBPgfZ2W
	D0vYR1tkWPo7EelFOOCiCXVjI+Iwho77hZhBO+wltRsEOzyANKHvh7XjMfA6SO6k54BSlxoSYZc
	EXdy0rjhFYSZA=
X-Google-Smtp-Source: AGHT+IGO0sdRqkIIMXrMz64LCPfszyelVKRHLvx6QYTw9Wu3NiMqUcvHo1zwd9gbJsl9nWcYchOwkQ==
X-Received: by 2002:aa7:8317:0:b0:7ab:242b:95c6 with SMTP id d2e1a72fcca58-7f131e86ee1mr2417187b3a.6.1765339966325;
        Tue, 09 Dec 2025 20:12:46 -0800 (PST)
Received: from localhost ([122.172.86.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e2af93d910sm17380963b3a.67.2025.12.09.20.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 20:12:45 -0800 (PST)
Date: Wed, 10 Dec 2025 09:42:43 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Pavel Pisa <pisa@fel.cvut.cz>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Michal Simek <michal.simek@amd.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, Pavel Hronek <hronepa1@fel.cvut.cz>, 
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: arm:xlnx,zynq-7000: missing CPU freq in /sys after
 6.18.0-g8f7aa3d3c732 from 2025-12-04
Message-ID: <nitrtsck5moqc2xfovcgc2tppkbfd7224jb6iaezetjgfjmvjf@hhdr6hwqwknl>
References: <202512081758.02574.pisa@fel.cvut.cz>
 <6hnk7llbwdezh74h74fhvofbx4t4jihel5kvr6qwx2xuxxbjys@rmwbd7lkhrdz>
 <202512091447.26580.pisa@fel.cvut.cz>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202512091447.26580.pisa@fel.cvut.cz>

Fixed Krzysztof's email id.

On 09-12-25, 14:47, Pavel Pisa wrote:
> Dear Viresh Kumar,
> 
> thanks for fast response.
> 
> On Tuesday 09 of December 2025 06:37:02 Viresh Kumar wrote:
> > On 08-12-25, 17:58, Pavel Pisa wrote:
> ...
> > > and we experience problem that attempt to set performance
> > > scaling governor though
> > >
> > >   /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
> > >   /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
> > >
> ...
> > Try reverting:
> >
> > commit 6ea891a6dd37 ("cpufreq: dt-platdev: Simplify with
> > of_machine_get_match_data()")
> >
> > Also if you can provide your boot logs, it could be useful. Either the
> > probing of the cpufreq driver isn't attempted, or it just fails somewhere
> > now.
> 
> The cpufreq is back after the revert.

Great. Thanks for testing this.

Geert already highlighted an issue with the commit earlier [1].

Krzysztof can you provide a fix please ? Or do you want me to revert the patch
for now ?

> I am attaching logs from failing mainline, then with
> revert applied and their diff. At our standard debug
> level, there is only single line interesting in the diff
> 
> +cpufreq: cpufreq_policy_online: CPU0: Running at unlisted initial frequency: 666666 kHz, changing to: 666667 kHz

Which means the driver is probed. With the earlier mentioned patch, the
cpufreq-dt platform device isn't getting created probably and so driver probe.

> The rest are some timing perturbations (lines swapped etc.)
> and at the end mismatch in dtbocfg with test kernel.
> But we have run whole round successfully when the revert patch
> has been added into test automation system.
> 
> The /sys with the revert patch applied shows next
> cpufreq entries (only some subentries shown)
> 
> /sys/devices/platform/cpufreq-dt
>   driver -> ../../../bus/platform/drivers/cpufreq-dt
>   driver_override (null)
>   modalias platform:cpufreq-dt
>   subsystem -> ../../../bus/platform
> /sys/devices/system/cpu/cpufreq
>   boost 0
>   ondemand
>   policy0
>     affected_cpus 0 1
>     related_cpus  0 1
>     scaling_governor ondemand
>     scaling_available_governors ondemand performance schedutil
> /sys/devices/system/cpu/cpu0/cpufreq -> ../cpufreq/policy0
> /sys/devices/system/cpu/cpu1/cpufreq -> ../cpufreq/policy0
> /sys/bus/platform/devices/cpufreq-dt
>   modalias  platform:cpufreq-dt
> /sys/bus/platform/drivers/cpufreq-dt
> /sys/bus/platform/drivers/cpufreq-dt/cpufreq-dt
> /sys/module/cpufreq
> 
> So the all seems normal from my understanding.
> 
> The device-tree is slightly modified zynq-microzed.dts,
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/xilinx/zynq-microzed.dts
> 
> the console is switched to the UART0 which is routed
> over galvanic insulator and break to reset cicuitry to
> the FTDI device on baseboard. System is connected to
> OrangePi testbed controller with test system power
> supply control etc. 
> 
> If you have some patch to test or some suggestion
> for some testing with more debugging options
> switch on, then I will be happy to test that
> as my time between teaching and other duties
> allows.

-- 
viresh

[1] https://lore.kernel.org/all/CAMuHMdVJD4+J9QpUUs-sX0feKfuPD72CO0dcqN7shvF_UYpZ3Q@mail.gmail.com/

