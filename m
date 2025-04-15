Return-Path: <linux-pm+bounces-25493-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C7DA8A721
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 20:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0894A19025E3
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 18:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A2F233132;
	Tue, 15 Apr 2025 18:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="1+MwscUe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAC122F178
	for <linux-pm@vger.kernel.org>; Tue, 15 Apr 2025 18:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744742895; cv=none; b=nhFzTNpdDL9/ky3O+L8ycBm8FyBpvA1ES70y0RIK6f9e+y4PVb6leLmh1ZmHwP29cIa1Aaw1MFx/8KXAu/L/GPbyaj3+tD/TYUjN0nJLtLYHWWTF8sbFuQCmPPW+uFb66L2uxz5s5tZMVbYa2DfYOZHNLUhj8L0YcETva0Sp7ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744742895; c=relaxed/simple;
	bh=jyspZm5GDyE8V8MqM0DVGyy+s9l/GwhLFwsgaQQGonw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2dVbj2Ft451RM8o0H1Jxvxo5GtTt5klCQhPkDkprK5Q2zmZ/HQi0QaQsha2ztUIl4kFYWzo4NMgCo34eH4IOZRdDtcw6HMLpFmCa/OAG75MNSdG3yC0Gs2lgz57Ojl+vJrUxWg/Vo0tZIH/tGuf5dhut+bx8K9qtiHQlMW8+fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=1+MwscUe; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-73972a54919so5050007b3a.3
        for <linux-pm@vger.kernel.org>; Tue, 15 Apr 2025 11:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1744742892; x=1745347692; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=glUhvdbg6jDxSzyhesIM3rd1JyjGcrsNSGuSqUFVHug=;
        b=1+MwscUeTVfBM7bjPdLu6bUneloOL81f/Yya/cT52SsUTCY15XkjAkbKP9kJVSn6pG
         wM47IBzFbvRklbgrnGDSEnHY0APRUns77kG9QBm/lFehrbl4dvpFKQjhFVvMoa/EVlDZ
         W5IEz0GRUuIvoUmLHgQre9ifjnI8Oil1YZGGd3TPD02qm6aSOzsefOt7UvFLcqICue3z
         ZvFN6NJaDsf476XVogolYLzskAMkulEZuSeblXHi9JIePHQ5q9dcsugiq+c9XSEQ36Mh
         V3Uc4P6QXEhXFxSCEleM2ra5orNvvE11i/VaOIKrkBNcUwffOpwNGiFIhbFslHZczUFy
         xPbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744742892; x=1745347692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glUhvdbg6jDxSzyhesIM3rd1JyjGcrsNSGuSqUFVHug=;
        b=sDEmWolwZ9ykGmZpEidtz+4NeLNM6GTRUxDCpY4zVL0OIGXObSzfKJGlJChtGzaRDl
         Go5gAD/wQah+JRQsmVr8yi15CJzexubZLbQcBCEEiR0HuTQNGgRgfbTYJeBdfnYg8Cvc
         9CfQ1oGpDYVGlNFBS6oBKqTaKrTlxqFWKTQN7mrfWrnoZ/W1F1s80IYlcOGO0MhTesB5
         Eiimy0BtBrJQbZuSsgrj+tJ8vtRsr801Jv98OWEcseOLEDb7bB0VFCP72zOQYBvvZu7Q
         QeovizkW9uMlsdj/jThFRxPN1UEl7y6W5kNBIRzTVFScYyLMo7yVjMmpxS+3KJjmfZle
         hIqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoKinGYBQHk6oQI+BLoezcD6cDG332+d4pZ7LoQ043MH93VyMQJTZXwaZzfufKI1N5zxKCeavdsw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ8P4eKwGDOl/e3I4LQ/X2onmh7Cy0kNzqtj56vCDdP0R97sZb
	QFgMW6GvV/gAkKx1YM42l8FbdFEQfuFEkyUnW9tdqDlIUhxsUvB3njOOhbn0/mY=
X-Gm-Gg: ASbGncu5wR7BV70/z4AkVQxbYWokhm/MxMlA7Aa5ojXTHPCyL8ITY6kTL8k2Ez873MP
	yHJfmkPQ0R7959ZVUvut3Bl/EQRs1jvel/am8pGZ0zrbXUild3yLB9scoe79SYGjS9pfabyEQk/
	NgORH3FsPqP057ypd1nVD68AQrOD6xAInEhdwoH8oGunL5EouLWc3ipT7SG638FybOwqM4/WdWE
	CPgy6Tp/XA9VwTg2OGETsMdl7fIrBV6EdM3cS7DeVAi3IocTTLCL5bxYDEHBOovuvj7PsGwHomo
	F55rcXd3Y3yvQmSqUC3N1qlgewpx+5q3XZC+sXulCDuEkos=
X-Google-Smtp-Source: AGHT+IFU1A6IgDtbE+ayph1nkrk/Xkmje9tzi2mXCLVIUeRmrboHqr3jd6su6fZeet5H41nBKRVWlQ==
X-Received: by 2002:a05:6a00:a26:b0:736:3979:369e with SMTP id d2e1a72fcca58-73c1f8f742emr628913b3a.9.1744742891991;
        Tue, 15 Apr 2025 11:48:11 -0700 (PDT)
Received: from x1 (97-120-122-6.ptld.qwest.net. [97.120.122.6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a2d3a4ddsm9578290a12.49.2025.04.15.11.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 11:48:10 -0700 (PDT)
Date: Tue, 15 Apr 2025 11:48:08 -0700
From: Drew Fustini <drew@pdp7.com>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, guoren@kernel.org,
	wefu@redhat.com, jassisinghbrar@gmail.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, frank.binns@imgtec.com,
	matt.coster@imgtec.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	simona@ffwll.ch, ulf.hansson@linaro.org, jszhang@kernel.org,
	p.zabel@pengutronix.de, m.szyprowski@samsung.com,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 19/21] riscv: dts: thead: Introduce power domain nodes
 with aon firmware
Message-ID: <Z/6p6MQDS8ZlQv5r@x1>
References: <20250219140239.1378758-1-m.wilczynski@samsung.com>
 <CGME20250219140315eucas1p10f08d297580edd114f4c487c1fbffa8d@eucas1p1.samsung.com>
 <20250219140239.1378758-20-m.wilczynski@samsung.com>
 <Z/2+rbhsaBP0DQop@x1>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z/2+rbhsaBP0DQop@x1>

On Mon, Apr 14, 2025 at 07:04:29PM -0700, Drew Fustini wrote:
> On Wed, Feb 19, 2025 at 03:02:37PM +0100, Michal Wilczynski wrote:
> > The DRM Imagination GPU requires a power-domain driver. In the T-HEAD
> > TH1520 SoC implements power management capabilities through the E902
> > core, which can be communicated with through the mailbox, using firmware
> > protocol.
> > 
> > Add AON node, which servers as a power-domain controller.
> > 
> > Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> > ---
> >  arch/riscv/boot/dts/thead/th1520.dtsi | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
> > index 197df1f32b25..474f31576a1b 100644
> > --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> > +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> > @@ -6,6 +6,7 @@
> >  
> >  #include <dt-bindings/interrupt-controller/irq.h>
> >  #include <dt-bindings/clock/thead,th1520-clk-ap.h>
> > +#include <dt-bindings/power/thead,th1520-power.h>
> >  
> >  / {
> >  	compatible = "thead,th1520";
> > @@ -229,6 +230,13 @@ stmmac_axi_config: stmmac-axi-config {
> >  		snps,blen = <0 0 64 32 0 0 0>;
> >  	};
> >  
> > +	aon: aon {
> > +		compatible = "thead,th1520-aon";
> > +		mboxes = <&mbox_910t 1>;
> > +		mbox-names = "aon";
> > +		#power-domain-cells = <1>;
> > +	};
> > +
> >  	soc {
> >  		compatible = "simple-bus";
> >  		interrupt-parent = <&plic>;
> > -- 
> > 2.34.1
> > 
> 
> Reviewed-by: Drew Fustini <drew@pdp7.com>
> 
> I tested this on top of 6.15-rc1 and found no issues.
> 
> -Drew

I've applied to thead-dt-for-next:
https://github.com/pdp7/linux/commit/2bae46e3de2a64fe3a619d61b16da0c01b8df2a1

Michal - are there any other dts patches that I should consider for 6.16
PR?  I would probably send to Arnd around 6.15-rc3 or 6.15-rc4.

Thanks,
Drew

