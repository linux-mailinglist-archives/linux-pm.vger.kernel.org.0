Return-Path: <linux-pm+bounces-32883-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5652B30E80
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 08:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC7415E5D41
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 06:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB99D221540;
	Fri, 22 Aug 2025 06:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DMJxFvmD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B7A16FF44
	for <linux-pm@vger.kernel.org>; Fri, 22 Aug 2025 06:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755842774; cv=none; b=ofUoTg4znaDyYBYGLFB8a3FZbdy3+c+sVo9W26/Ks6PbrN+K+zGIJAGYl8P4d/NFI9pU6Za2xNgruQP9bHlpNIHdRjBpcLt3qYj/j39lPd3lJ5ioEjyDwWU6xQ/hG557pBzpxSxIwN+/IQM/fSLE7WJNXdDH1m/vuk2v4VW9MbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755842774; c=relaxed/simple;
	bh=HGqWuoHgmmgHoSzHhFhnGFrp/claoOUiLRgGZX10r+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVqjY24efz1SiSUYN5J4r+qusNHwk2D+4FlD9E7oGsOXtX8ZOi8TKMoFCmwwTUnirTVtBF3czfae/MsKfHG24nbFs5d1fAUFP6FH070VsQHvvX8MbXjXXo+hN6xHhnEOWauMbbnhzw+/At9y1r4QnFgAynTVNcLAD+nVUjBj3/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DMJxFvmD; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76e2e8e2d2dso1286089b3a.1
        for <linux-pm@vger.kernel.org>; Thu, 21 Aug 2025 23:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755842772; x=1756447572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aRj4gWuvSe9KJNF2HvWgOVVCeMpYCcJ3nSN/Zd2LcHQ=;
        b=DMJxFvmDwwnfaVQEyBimhTyC3/vAl8YX4HmwenkWr99X+4uER8nR878f8WzC6IojkE
         PkVHD2fbFmLVpx/ZUobGQcsP0SexyAfVEYBJ9v0mwF+wbOaglQwObYtVjCLdiCjmFVEb
         h1Ns+UasMGZYQmHjmB9MbKo+rtGKjsRvJ4g5tyivd7Uf6R3zFEkQh2y6vL/QBW954EqO
         4LeluaYYWFlRS9AWaryVHcGXJZCCFtG8YCOjH+qtESboqPBE1fhv98sQmXxBACha6/Lg
         dID8CWqtyH9JIP+k9hAgEDcnEx4OGgcaDs5uNAwvikhGXLmnoub40MJFmkBZK1xLIuyH
         G5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755842772; x=1756447572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRj4gWuvSe9KJNF2HvWgOVVCeMpYCcJ3nSN/Zd2LcHQ=;
        b=bBUDQE6TU0V7bhI+2VM6DUcOrQEt0xqy4W9+X7qMPikNWQaOVwbAcHS4CydP/Ooali
         SpM7uTft5OMxTBiG2UHQtOrBlgO2rNbOwWEk2/fhZ2F4LnxKBwa1mtEQpuImU0Ud2C0Y
         uLA72a/8/swRMiqhLCUrJirq7g/0k+85yDFgu/ZBH0iovscaRDd/yBhmM7qIYCvVYQn5
         WGa9dfK9xy1eucBkHv2T2yibJWMhmLBTsfMs45DBpjXowPINKa3TXDIdwn3fi1H0z4H9
         du4iP+jZ/1dRnZaPWpcfSlR9QxQGTbxFNxnz97xdKwyR1alrUxKuCL1K2X4ZkVAmwZFW
         y6fw==
X-Forwarded-Encrypted: i=1; AJvYcCVqawriSI8vc9GGCUIQ22QJMNtlQQUbd37dAOrLkYF6TZ/4X1o0OYF1TS5azbNMFlxilzmm2qdPWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4P7mAv/DvYIa6mZSU/aNmkwbdSju6rHAN6t8gIWUvpG/tqX1F
	mfedaDYx5XmkhpaXaLrmFKD+hvjYBZHAqjWvDZSs/Qc0/fe7iECzyQfeleNiA9/zVbM=
X-Gm-Gg: ASbGncsxhjnnngyb6pIQS/1JMtS7E6g5cinREKyWoon610Lq5RanaugVtpr0cd2rZaJ
	W58pdyRKUo8v6Zw7xPjFecRNcgLNBiX14aDs5JQJ9rProW6Qi66oLWOi2QWHJrIpINs0Zvysy1z
	TP29+la04/XUdfD4ySSutT7/xcmRgqIMTXau+OgRSrOxVfYLTzvjlOflhz4xG0VtF5hccr2mMlD
	sDjkz171CsjVRf7DBndy5Bb5RRKl8bcahbYnY93tGkBM60Yq8Nuy3594YdszeitYu34PG9zddqJ
	gi2iYkhuVx2TakZzYCo7j7eDFQT+vgBHU1Y6MikWnmUu11SlKBsDvqKNXrZa+zWNzowEzBGiENg
	jsU0oyeZzaVh40dfg0M293U+t
X-Google-Smtp-Source: AGHT+IGryQhx7NkdJSDc5m5rZZNOBqLyR8DTgK4iIdr8kRPK/dFFCXNh+UbON3GVXLnVhVtonBLu0g==
X-Received: by 2002:a05:6a20:3ca6:b0:243:78a:829d with SMTP id adf61e73a8af0-24340e4640dmr2844133637.54.1755842772379;
        Thu, 21 Aug 2025 23:06:12 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-325154999f1sm1475868a91.25.2025.08.21.23.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 23:06:11 -0700 (PDT)
Date: Fri, 22 Aug 2025 11:36:09 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Judith Mendez <jm@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Bryan Brattlof <bb@ti.com>, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/3] OPP: Support more speed grades and silicon revisions
Message-ID: <20250822060609.djvsm5nmryit5ypl@vireshk-i7>
References: <20250818192632.2982223-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818192632.2982223-1-jm@ti.com>

On 18-08-25, 14:26, Judith Mendez wrote:
> As the AM62x, AM62ax, and AM62px SoC families mature, more speed
> grades are established and more silicon revisions are released. This
> patch series adds support for more speed grades on AM62Px SoCs in
> ti-cpufreq. Also allow all silicon revisions across AM62x, AM62Px,
> and AM62Ax SoCs to use the already established OPPs and instead determine
> approprate OPP application with speed grade efuse parsing.
> 
> Also fix 1GHz OPP which according to device datasheet [0], also supports
> speed grade "O".
> 
> [0] https://www.ti.com/lit/gpn/am62p
> 
> Judith Mendez (3):
>   cpufreq: ti: Support more speed grades on AM62Px SoC
>   cpufreq: ti: Allow all silicon revisions to support OPPs
>   arm64: dts: ti: k3-am62p: Fix supported hardware for 1GHz OPP

Applied. Thanks.

-- 
viresh

