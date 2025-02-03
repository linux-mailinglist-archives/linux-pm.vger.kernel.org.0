Return-Path: <linux-pm+bounces-21290-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC99A2575F
	for <lists+linux-pm@lfdr.de>; Mon,  3 Feb 2025 11:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18ECE188233E
	for <lists+linux-pm@lfdr.de>; Mon,  3 Feb 2025 10:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13128201256;
	Mon,  3 Feb 2025 10:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PjGpBAiz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C03E201246
	for <linux-pm@vger.kernel.org>; Mon,  3 Feb 2025 10:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738579911; cv=none; b=OsqWTaaByKsEitsrBsqYDxR4FFSBlqa7b1XjYpSEs+ekaN8QBqBI48eaDTIYXaR0eGFS7Bk11rJhBQ/JEFODPxxyTa8grYi/gpL02AdU4zZX5IPT76O2hkHFIqqCUnK8RSYAQoJPTnYPcjKYAwMxlhorbv9v9iP3cPmB8y1rReU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738579911; c=relaxed/simple;
	bh=gJC4QoiK8MGigX6f3IDnwGzKPQ76ZnM7gy6Q3GmPbPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SFPp5Rx5NFa+wel3K8/soU4hN1pzAHnQSfkImPbbQXBRTks5pgTaFEN6kdO2Q+rX4xudeUr+u59xu+C6RsAuzDPJ3AUwB9hWucWyJDrDEa86JQRpmwCqTkPLIgAeshEMsX/VsvEn9ePrrpCEvBsOuIkCw/7DnbS6OwMHTDCnCho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PjGpBAiz; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21669fd5c7cso71596215ad.3
        for <linux-pm@vger.kernel.org>; Mon, 03 Feb 2025 02:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738579909; x=1739184709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TpTYY6NVHOTQPLmGd20ggvva9b+UkoAqQ2BAc0zy2SM=;
        b=PjGpBAizk3WBsKH+mvf4Euf7wN9WJ/bCh9s4uqYerP96BExD84Pgbb7rtr9V5WAY16
         XKuZx7/h8v9QsWd2/hNjGRErnjGtBLgHfsOy+KCD3I2OOqaEtpWB8tD14KNDk1RgOk8t
         /iodKbS06SDU2n6yYEPuA5y51PeVox3Nl5Pw0PHux/3f4/+qiU2J42w1GO9Tqo04GJ7X
         i/eN2BButEoFzw1Zn5nmZXt2Z/JfJE3j/Z9xlM17EhdQsdfPJ8r7qjYxW0Q6WGklK7NG
         698Jo6ngdBc0VIz3K/VDN/45q/zn+Af0ZXWQJBdfQtpsoTRmlE7Qs6VRVfEuaoEoragc
         ohnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738579909; x=1739184709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TpTYY6NVHOTQPLmGd20ggvva9b+UkoAqQ2BAc0zy2SM=;
        b=ok09fWJKb+/l4b+QoyGhb8XoSzXyN3diXba5yMVBZVhssWBPy7e8anbV5s7Anup03y
         WcP9HAE72pAYbvlQoJ4aWH17C6PGJCroUawmUkDuSrAIia9kWiXsFyun8a3UanKxq9TP
         oJaGRINBdSQ7IFq/KxDSMM4VKF+YiUypylENLzZachNs7Y6/SvQvNvac9ICYcUTGg38o
         Up9P9VXwCjiplAAn0twx2VPw2m4MvPHk++6tXNPnA+eSdIfLmtT2IDDk+pmE3F+Xhg45
         ZxUpHn3g69A1lfr/LwDUNORISfR940gL0f9FtxE1lxxHemZP/g7WRkJiFGmU3vmlq27l
         vgLA==
X-Forwarded-Encrypted: i=1; AJvYcCWVtSNEhYPMMFgI2rNW8Wp34dPFQ3vdvGHv9120/F5OVqM8dAO5KyZUFjsONGtvdzDg5L/Xf+Svcg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyzQMsmYCvLusv0ZsAvxy0IYTIsePj0zbmJolLGK2MjaAwpveJa
	FcApsu/2tmfb+n9FkoqUY8XipMXgve9zcKA6jRGxiz8M/E5TE5WUtf8yjXbM7Tk=
X-Gm-Gg: ASbGncvKdOUYqqbXrEJieuMPIQr0W3qZ7ED0FZ7+gtpl7DnflsIht3bauRRhkS0DRf+
	4LHLu/YrYLmp3vfXhh2kED/o2Xr+E1eRmgsGAC0IWtWWZjCdEaTUh0QRuRG2Qo3skMdYhAwbAsA
	f7YM3xsAxjsdDoeCBttmEjVTafQgSHvsEp3SvgZeStKW26b3pdOc7gyUS6Kse4sQKrfwxI/HRqn
	TlBCXxgdVCEXxF+7c8FeZFkq/C73WH3TWLpu0mVqEieheB5C+SpgdqYKe9sS01Vg8aF5VGjuuMW
	6gfrPdO26m5DCyVv4A==
X-Google-Smtp-Source: AGHT+IGxMLDlIMSaw3Z8cWeu4NnMK2JLensF+qmNnQk7oU5j+h5mOuW/KaB0EYuSyfJh18W/YDA4sw==
X-Received: by 2002:a05:6a20:9188:b0:1e8:b17a:a556 with SMTP id adf61e73a8af0-1ed7a5f9136mr35623177637.15.1738579908746;
        Mon, 03 Feb 2025 02:51:48 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe6a1a766sm8026943b3a.161.2025.02.03.02.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 02:51:48 -0800 (PST)
Date: Mon, 3 Feb 2025 16:21:46 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: zuoqian <zuoqian113@gmail.com>, sudeep.holla@arm.com,
	cristian.marussi@arm.com, rafael@kernel.org,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: scpi: compare kHz instead of Hz
Message-ID: <20250203105146.6yuzypgb65bu4xrq@vireshk-i7>
References: <20250123075321.4442-1-zuoqian113@gmail.com>
 <20250125084950.1680-1-zuoqian113@gmail.com>
 <967a5b3e-197a-4b90-9fe3-9b10782d677c@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <967a5b3e-197a-4b90-9fe3-9b10782d677c@stanley.mountain>

On 25-01-25, 16:04, Dan Carpenter wrote:
> On Sat, Jan 25, 2025 at 08:49:49AM +0000, zuoqian wrote:
> > The CPU rate from clk_get_rate() may not be divisible by 1000
> > (e.g., 133333333). But the rate calculated from frequency(kHz) is
> > always divisible by 1000 (e.g., 133333000).
> > Comparing the rate causes a warning during CPU scaling:
> > "cpufreq: __target_index: Failed to change cpu frequency: -5".
> > When we choose to compare kHz here, the issue does not occur.
> > 
> > Fixes: 343a8d17fa8d ("cpufreq: scpi: remove arm_big_little dependency")
> > Signed-off-by: zuoqian <zuoqian113@gmail.com>
> > ---
> > V1 -> V2: rename freq to freq_khz, change rate to unsigned long, and
> > update patch summary.
> 
> Thanks!
> 
> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

Applied. Thanks.

-- 
viresh

