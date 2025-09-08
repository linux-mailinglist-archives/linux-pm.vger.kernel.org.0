Return-Path: <linux-pm+bounces-34129-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4E4B484C0
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 09:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC2201B2039E
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 07:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE0B2E6CB6;
	Mon,  8 Sep 2025 07:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ml2mmTlo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790772E5B1E
	for <linux-pm@vger.kernel.org>; Mon,  8 Sep 2025 07:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757315034; cv=none; b=NuB8Sg20xj7k3fackeuzo+Q0ePBEVcbgtFabmhEXHowRKCbx7c4vhUzePDe3zoZ9zVdzXNGcgbeuiGdL4b7mNbqUWRobi+iTSK+J37wTRedleXVhKotdDzNDYai1Vh1TKRtCiJp69geTAOWyD30PybaLAAA9vSI4ymjODAwZH9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757315034; c=relaxed/simple;
	bh=IFQSsw7X2lJbg2eU0tkmcDM/OFT1IO01YnqUQ2sDIUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MtPDkd+JfDshKTwvn+6+fExEASA4tk4Q1Rzj395XdOXv9ddVMRlZoaNrM7x/XdtE8D0mUisi0Yh3Hc/nq+q7cCpk2XOf8JeRc3FYgJMvjzaAfW+GcRHwIF+LApB2on1g8LiFcBr+JhHXCdGGkylN2tyhTIOjd+lSS7qhkt1EbQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ml2mmTlo; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b4ee87cc81eso3725099a12.1
        for <linux-pm@vger.kernel.org>; Mon, 08 Sep 2025 00:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757315032; x=1757919832; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+xM4p/zyaJz7z9vlZN3il8DQFkpBC93i/XYk/dKxNDs=;
        b=Ml2mmTlol0pjRBy/jnvuNKbuhrHj9lRhfet7IVe3yw3n6zObqXEZDy7fTvfbPJ3bVU
         4dNMOZb85Q6uvEcV/aoT4CSY3UbdIR3U4YL0gCxTaZsH7DtaG8hHurdOXIQsX3NsXc2E
         eRCa9wYguwux6t3DhUn2sAG/iZlEsPg3kjfqkG2yVJmfSMZiFdDJvjlP1QoE9OXuqp9a
         9JhEaPsLn1djpX47bE2Bsy+eBi9cj9i+8+XKhVWrnIyMgYYQtCiGBKJIkj1O8ZuKS7Ja
         lv04Pgg3nsSEb8jsitFpO+yXSsJt5qxUZid7eNSyB4OWEhjBfVM64R79U2PJCWVA2YKS
         vrnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757315032; x=1757919832;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xM4p/zyaJz7z9vlZN3il8DQFkpBC93i/XYk/dKxNDs=;
        b=dFr+cC5scwDRA/xDFHgWdJFh2VtBwbNsasrCXFuqHhyYvPwCAtx5MidgX6Cv93NSZV
         xo35QffmV9NvIEJ/DiwO1Zb73QZGMLyJcGX8EL5383QWVJKa1j33ZtfdoSUH7p61mP8S
         d9ymWiAuTKKFoBhpuCb7eliVJBJFQOCfmM43NXxQyCpbUJyA4M9rymaMMk+E+BSHCrTD
         fOFnRjkiSS1rmmOxl4GcCwZPEddKhyvtS23vckEcrXmAAiQXYFadHT9DcjRwt2NNEL9r
         tK4DHqcCNwby5GegbEvTbJENlQ5M797VzQrVkhtjmzKVU106K+yFpz+cgjTJUoMhD0au
         sz9w==
X-Forwarded-Encrypted: i=1; AJvYcCUbIbqDc9/JCwyDufWzFFIop7ZZRtNskWLA/mJ1su8M6CvjxX0jWT7+eRbQn3VR97jfKzyjELTC1w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx3eyqsR6A1nKyWmao+63Y66+cqqF/pcyM1E/f6ieKYgX78H2N
	+2VlZH46mXZUVSLhnTeniWt7aJ1uRzkU1B+ac+eWVokFK3uN8ycw1I0LxK2bKbeTOWk=
X-Gm-Gg: ASbGncv11AIRP92rAnrn5RTvKMEqUiKVkdZltBu/lyufoV6BKfg/oFBYHYbt5sVjVs3
	n6fUtWZtY85/abpOrwhCDQY9es91TVEAfySL0S68DQBwRTJDgfSA7IxHuSZjY6PrR8yMxBG4G/g
	s+FsaOjYob22qU4PlxvCEK5JOa896BBvWxgKt7i8ij30E9BidWZZS0hdu4SdYEva2oiZ1STy/NG
	Wz1A1cTQb4nXs+DVB0OmaRV2S4Ry0ulhjQ451QbX8o+u0+/iuZTgOSYym4SY6XPJpUV8Cs40zA/
	QM/5a5chJaiJz+zl0X86vRD1IaoigiICalPqBdv/dhA+gHGrwHnt03f9xSGiirNiEQGZMppCbTX
	Q0T8NuaFx6cgIHcazAHYYsM50elzpMwj+8XE=
X-Google-Smtp-Source: AGHT+IGdeCh/rybFQC/2arp3UhBEUX+o56WdtJ71SfDZ99wsZPoSxMLD22J5lDCxlaU3DSTir3vf/g==
X-Received: by 2002:a17:902:ec8f:b0:24c:7862:41e2 with SMTP id d9443c01a7336-25171cbdecemr112986595ad.31.1757315031785;
        Mon, 08 Sep 2025 00:03:51 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77248cfbc9esm23739860b3a.99.2025.09.08.00.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 00:03:51 -0700 (PDT)
Date: Mon, 8 Sep 2025 12:33:49 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, webgeek1234@gmail.com
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Aaron Kling <luceoscutum@gmail.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Thierry Reding <treding@nvidia.com>, linux-pm@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mikko Perttunen <mperttunen@nvidia.com>
Subject: Re: [PATCH v3 0/2] cpufreq: tegra186: Fix initialization and scaling
Message-ID: <20250908070349.nsep6ekt7g426txq@vireshk-i7>
References: <20250828-tegra186-cpufreq-fixes-v3-0-23a7341db254@gmail.com>
 <20250904050358.kj7gxypu5mmov4f7@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904050358.kj7gxypu5mmov4f7@vireshk-i7>

On 04-09-25, 10:33, Viresh Kumar wrote:
> On 28-08-25, 21:48, Aaron Kling via B4 Relay wrote:
> > This series fixes an issue with shared policy per cluster not scaling
> > all cpus and with some cores being initialized by the subsystem.
> > 
> > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > ---
> > Changes in v3:
> > - Use more clearly named variables in patch 2
> > - In patch 2, fail probe if no cpu rates reported by bpmp
> > - Link to v2: https://lore.kernel.org/r/20250828-tegra186-cpufreq-fixes-v2-0-fcffe4de1e15@gmail.com

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

