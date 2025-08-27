Return-Path: <linux-pm+bounces-33201-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9A5B38576
	for <lists+linux-pm@lfdr.de>; Wed, 27 Aug 2025 16:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0AE03BED92
	for <lists+linux-pm@lfdr.de>; Wed, 27 Aug 2025 14:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EC521884A;
	Wed, 27 Aug 2025 14:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="lFrIB6/z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA86A1A0711
	for <linux-pm@vger.kernel.org>; Wed, 27 Aug 2025 14:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756306343; cv=none; b=bpiluEOczoWWM3JLPyttLosL8EehZjR5HV0vq3gOL63QF1WLxZhValfKL5HUrOdahognlbev4Z/csN4wEFuczhxJm+ztvhmXvStdAiIyyIaJBypbo41/9PmEw/07VWEexC07izov3BnRWZRGBKU30vD6qT85VJszqaXztao1qdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756306343; c=relaxed/simple;
	bh=ThVMa0VjSVebwOgOVvao7s4xw6N5DyuHLHJOViqjIao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8N6xn2RAS35XpZBiw1dfVg7EcgGKTLBWxM1/l3JFeqLcTTgeSUZ23+2HteS7ZHYSnmbNiGLd6YUwfIUIBoexODLjivZgqsbpN2w8i9u+erA6/KDkqSTWNSUVgAnssojLYa/+0j1zjGokiiKUnQHF3nFcipCUax3Wan/DGX8u3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=lFrIB6/z; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b109c63e84so73776951cf.3
        for <linux-pm@vger.kernel.org>; Wed, 27 Aug 2025 07:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1756306341; x=1756911141; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DzCFdrHjD97smBgVN53iARzVNKgmIKQSQPUy52DLyR8=;
        b=lFrIB6/zV+TnWJS9GUJpgCVnlT0jdVkV4uZ+g1dxzysM0uYvDcbLUtI8Otj8gOInNw
         wdjEcMax2I7lfVzuniO2409gjlQmgtD1ceSXoUoIErq1CDpSOFuGBVHFbPoLHHdM3dhi
         TntyKwtuB3aGWxQ4v9ZTUx32bIgQfemFmBp64BAMnZj95zKsJrkB75V2bDek4lYA1es9
         kay9Pv+55F5393svhQilKbZDN9bMy7E9F7XH6wf6HWMYvN9PqfBARv4vlVUhQ/Okuzlk
         DtvZ152suTrL2FXbM4GwComywuSdfVPpe2R9y2fcUXdcf+ky30qv1M49NLs5TKlj8j3h
         aaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756306341; x=1756911141;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DzCFdrHjD97smBgVN53iARzVNKgmIKQSQPUy52DLyR8=;
        b=Y8B+eTyLYvm1A9YDAlcOy27/fV4Mkvdc9FzdvaFwJoh0p7V8hXszPqRA7yxsfQZyKT
         S5Z/FWLZH+ilbZhCVLFa+NBTYNLk1FB90A4If1EdcPnS5yoJixiz6VrPMAXDYmMYMJoR
         fTKrTH0B9qN2MQT/A7V8M3hHUySEducC+uJOhp7wixOIC0bDuBxRqbGPfCif4uFm6oTN
         QcR/Xc2SoEYzlq66SnIOvp+Z/bcMNdZ2s8ZDif8kALZJ8kGtlxGx8uNUdlKMQ/PFd5u3
         l6a4EU4gGhTwpRfYkNU/tonDkyDiXB7GncKKmWko4OmyYUJqaipRZTVw6vb/HqGRf6/o
         lz7g==
X-Forwarded-Encrypted: i=1; AJvYcCWo+J8kQ+CEWp3QXyBNSNbINNmcJBVLlZB4G2TcV0Ieu0eYDKSvkFV0qoJ9NSRAxc+AWFE+Ev8BgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3eLv4UIETKhRAWImWnuOsU2ytkVucPRbmJLptxkQQ++Z6DANE
	eVdlRMbbJ72VMXAVw187x0W42xezCvbuj1UN7XCfETIWWi2R+fdAGTOhocCP3jJSw8WWM93z1Oz
	spyo=
X-Gm-Gg: ASbGncvahnR9hZfW22+/L8zRAhc7kM3xuqQn7UtuG3UPCCeUwcr2oJhBAaN3pHGStF4
	l+2o9g/LdazY3Xm4JM31Bt/aehbEUaKkJcXEw2oPmJeZIOkE6abdVu/QN7pDXb9QSOZlgf4uq8c
	XPJrr9e7kUiKbvFaSLAzBgDANz88c2vN53MQHiHETyBVrwnOiDzcVKl1WH8ZDmcQxnmIsZ0CYDe
	j4fTyc8Xhd9T9l15zuGXmlL5U9MnXBBd+ws7Hf9zLHQ9jm/ZUVecV/RoltcxhrGzy+/skyldOOy
	VzFYralV62tJJiacBmOqPVH50i23c4icWNfrHvL0yrp0gBrZA+VLUhM32Afyjusi0fxUigcHUn4
	0UCRXZSFS8p5YOvz99TNRBwqpySbr17u2rew2ziw/3sK1r7BB+FOvx+zWMg==
X-Google-Smtp-Source: AGHT+IGI69TxmEa7cNmRHXE8TQb0IknN+13n0MWxeBuaynrVToE2H9keJBWKDhweukHWinjWveqfuQ==
X-Received: by 2002:a05:622a:1390:b0:4a9:7a4e:7e93 with SMTP id d75a77b69052e-4b2aaa5618emr235523941cf.8.1756306340567;
        Wed, 27 Aug 2025 07:52:20 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ebf41772d8sm872657985a.64.2025.08.27.07.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 07:52:20 -0700 (PDT)
Date: Wed, 27 Aug 2025 10:52:17 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: ryan zhou <ryanzhou54@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Roy Luo <royluo@google.com>, Thinh.Nguyen@synopsys.com,
	gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] drvier: usb: dwc3: Fix runtime PM trying to activate
 child device xxx.dwc3 but parent is not active
Message-ID: <5d692b81-6f58-4e86-9cb0-ede69a09d799@rowland.harvard.edu>
References: <20250826150826.11096-1-ryanzhou54@gmail.com>
 <CA+zupgwnbt=5Oh28Chco=YNt9WwKzi2J+0hQ04nqyZG_7WUAYg@mail.gmail.com>
 <CAPwe5RMpdG1ziRAwDhqkxuzHX0x=SdFQRFUbPCVuir1OgE90YQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPwe5RMpdG1ziRAwDhqkxuzHX0x=SdFQRFUbPCVuir1OgE90YQ@mail.gmail.com>

Ryan:

You should present your questions to the maintainer of the kernel's 
Power Management subsystem, Rafael Wysocki (added to the To: list for 
this email).

Alan Stern

On Wed, Aug 27, 2025 at 10:09:10PM +0800, ryan zhou wrote:
> Hi Roy,
> Thank you for reviewing my patch.
> >
> > Wouldn't the parent glue dev already resume before resuming the child dwc3?
> >
> No, in the following case, the parent device will not be reviewed
> before resuming the child device.
> Taking the 'imx8mp-dwc3' driver as an example.
> Step 1.usb disconnect trigger: the child device dwc3 enter runtime
> suspend state firstly, followed by
> the parent device imx8mp-dwc3 enters runtime suspend
> flow:dwc3_runtime_suspend->dwc3_imx8mp_runtime_suspend
> Step2.system deep trigger:consistent with the runtime suspend flow,
> child enters pm suspend and followed
> by parent
> flow: dwc3_pm_suspend->dwc3_imx8mp_pm_suspend
> Step3: After dwc3_pm_suspend, and before dwc3_imx8mp_pm_suspend, a
> task terminated the system suspend process
> . The system will resume from the checkpoint, and resume devices in
> the suspended state in the reverse
> of pm suspend, but excluding the parent device imx8mp-dwc3 since it
> did not execute the suspend process.
> 
> >
> >Why would 'runtime PM trying to activate child device xxx.dwc3 but parent is not active' happen in the first place?
> >
> Following the above analysis, dwc3_resume calls
> pm_runtime_set_active(dev), it checks the
> parent.power->runtime_status is not RPM_ACTIVE and outputs the error log.
> 
> >
> >What is the glue driver that's being used here? Knowing what's being done in the glue driver pm callbacks
> >would help in understanding the issue.
> >
> Refer to the driver 'dwc3-imx8mp.c' please, maybe you could help me
> find a better solution.
> 
> 
> Thanks,
> ryan
> 
> Roy Luo <royluo@google.com> 于2025年8月27日周三 02:38写道：
> >
> > On Tue, Aug 26, 2025 at 8:12 AM Ryan Zhou <ryanzhou54@gmail.com> wrote:
> > >
> > > Issue description:
> > > The parent device dwc3_glue has runtime PM enabled and is in the
> > > runtime suspended state. The system enters the deep sleep process
> > > but is interrupted by another task. When resuming dwc3,
> > > console outputs the log 'runtime PM trying to activate child device
> > > xxx.dwc3 but parent is not active'.
> > >
> >
> > Wouldn't the parent glue dev already resume before resuming the child dwc3?
> > Why would 'runtime PM trying to activate child device xxx.dwc3 but parent is
> > not active' happen in the first place?
> > What is the glue driver that's being used here? Knowing what's being done in
> > the glue driver pm callbacks would help in understanding the issue.
> >
> > Regards,
> > Roy
> 

