Return-Path: <linux-pm+bounces-2703-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D4883B8D0
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jan 2024 05:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AA431C23290
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jan 2024 04:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF3A79EA;
	Thu, 25 Jan 2024 04:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j+RPm/+r"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5759D79E1
	for <linux-pm@vger.kernel.org>; Thu, 25 Jan 2024 04:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706158737; cv=none; b=Fs4wMkZir+/t9R77q80d9O8mnjWBl/B+A8Y0dC9g55xfpyKOc78N3PEs8FjCEQlK57IKKDGEmz/5yoEHu6VTjc+GCyuz7Yej57y06DfuaqDYLVAZ1PwpgfcNP141Vf7TYIw0QXW6c0i+grRucKn6o7CRwbbg87eERWBCtYaBl2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706158737; c=relaxed/simple;
	bh=jKgRaBrera7YyMCh7wCiTuLbZwe0CrLa611g0LvaYg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O9hDgEDWTCPolQMFEQvLAkEIZAypm0L2j1XkWF1ApdGQZClVJt+zeefDIR/XTZwNBwyJ8waNkXMFTq8jEo9JXi5RI/to/1T86FjxQHo45NltOlRj0Fy9sH16K+iOt3c5dmt8C5GTu5rFCCsOtKd/sxE5eQipfQxOly0gng+iruw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j+RPm/+r; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6e0cc84fe4dso3480451a34.2
        for <linux-pm@vger.kernel.org>; Wed, 24 Jan 2024 20:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706158735; x=1706763535; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tpo7S81Q6e7picJzGDOqqGEtmvErnEcq2Z13Hltk/j8=;
        b=j+RPm/+rhD2K5zx8ZglGmSn8BX5eFhM+76hB6UpKniqIwqWvpfXtIDlPikA4IGdyU4
         iItTN4nJXN8tf1+Vy94QSJdH8/VypVCzeMJMBUA7fjiZrZrXYmLDnuj1cI0gcV++OgNU
         L4bUBy1KBu1SWwEbp2WlsYBIYU3a0qf/YgWigRFWMxzxETISem0yzm79om7Ww13h8WIj
         JX58oS0acO+jeLGcy6MK46wdnyIKvz5xo3kx2to1cjbMl834hghBH3iMqujLL2yc6YrD
         8m7+l1biDiXuUFbtVrgEstFt4JXV0aJLAVpSs/l9kBhnwIKV/FjAzx6P88z/Ho3jB4Dz
         jerg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706158735; x=1706763535;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tpo7S81Q6e7picJzGDOqqGEtmvErnEcq2Z13Hltk/j8=;
        b=d5f2eVF9Z/Q06UEldVCG5C5Z5DO579ub8oqSJopW7QjtFcQyDPm4hdVxgH5fZtrz/b
         lcsOwYgUSB32bY0pojV5Py3cDCBa7e9B2MVYocnHA198Z68tjZpfvugzNXwPoiWM9NAF
         AaTjucAqBl4ZbiuhBlOzP7lD6p88ia7buoINoIJ85OnHSD2tm0Pt6TJXwipYFNFU7KHI
         Y/fsUZNi6FmPLp6b1x1xwzyhp5qyiwkGSHU+/FiQAD3HiXNwEwC7b1mHzj6zVwyYhFBs
         TXY5LBEWfnd7cqmLTuVqgN+A+zzsiudLEUXN2gJ45k31FBiYmTx0BBLs1RME253WHTtJ
         AEsg==
X-Gm-Message-State: AOJu0Yx2/JSUKzNENBJh24z17GzbafD4U7BtsRda9RK+cnQu5FaPDYh8
	Fs86957MFsHJ8fplXnEQK6my31PwrAnrYqPpM3Ener2h8J7Xh9g8OvIM87z7on0=
X-Google-Smtp-Source: AGHT+IH73ljD+tyH98GgQeFlyFzdp++7wNKTqWqkYp/Jj3Cf3NjheYdC9xQZhkIOcBEa0yaqPJi7jw==
X-Received: by 2002:a9d:7842:0:b0:6e0:e0e2:9e2d with SMTP id c2-20020a9d7842000000b006e0e0e29e2dmr209980otm.41.1706158735392;
        Wed, 24 Jan 2024 20:58:55 -0800 (PST)
Received: from localhost ([122.172.83.95])
        by smtp.gmail.com with ESMTPSA id t26-20020a63955a000000b005d5a7ddd656sm1109237pgn.36.2024.01.24.20.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 20:58:54 -0800 (PST)
Date: Thu, 25 Jan 2024 10:28:52 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	kernel@collabora.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	"kernelci.org bot" <bot@kernelci.org>
Subject: Re: [PATCH] cpufreq: mediatek-hw: Don't error out if supply is not
 found
Message-ID: <20240125045852.urocd3yzts5ajmbh@vireshk-i7>
References: <20240124-mtk-cpufreq-hw-regulator-enodev-fix-v1-1-6f9fb7275886@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240124-mtk-cpufreq-hw-regulator-enodev-fix-v1-1-6f9fb7275886@collabora.com>

On 24-01-24, 17:31, Nícolas F. R. A. Prado wrote:
> devm_regulator_get_optional() returns -ENODEV if no supply can be found.
> By introducing its usage, commit 788715b5f21c ("cpufreq: mediatek-hw:
> Wait for CPU supplies before probing") caused the driver to fail probe
> if no supply was present in any of the CPU DT nodes.
> 
> Use devm_regulator_get() instead since the CPUs do require supplies
> even if not described in the DT. It will gracefully return a dummy
> regulator if none is found in the DT node, allowing probe to succeed.
> 
> Fixes: 788715b5f21c ("cpufreq: mediatek-hw: Wait for CPU supplies before probing")
> Reported-by: kernelci.org bot <bot@kernelci.org>
> Closes: https://linux.kernelci.org/test/case/id/65b0b169710edea22852a3fa/
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>  drivers/cpufreq/mediatek-cpufreq-hw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

-- 
viresh

