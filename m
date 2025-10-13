Return-Path: <linux-pm+bounces-36007-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BF4BD64ED
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 23:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 73D234F49A4
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 21:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D961F2F1FC2;
	Mon, 13 Oct 2025 20:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hrxsi++r"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBDC2EF654
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 20:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760389180; cv=none; b=m/Ao70udPoTor3iXSrmwjKXBse0VaO0twfa45CE+M3wI8XHWKAZqjGvvvSL8+/jTaPRX20MOcvOM+Kd09fNaB/o+zN0CEPWyeYZEdwn2DoWswjkZqMue5XO64Z7S2E4aj2VLaXqL48c0g1oauRi5r3gjp+RsmoDgPeyBIMu37I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760389180; c=relaxed/simple;
	bh=sG7NGEDvazkQFTLe25gikpPASVjElHvfGph3Osk9HmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hkZLEDOwODKprhYNiOWmTNAYvrb8YOz3QgTVUowz7Sks2/rpzW5ZsTdWRCR0QkWCsPysAq/sJBymKfPH0xAS68xBCGcPij6Wsx8Tahmt2tKFL5BmpL4+bbDc66oE+gfEKb2XI74GatptobJJRL9TAkTHE6k2nvchlgY7cU3r+FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hrxsi++r; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5906665139cso5839824e87.3
        for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 13:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760389177; x=1760993977; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sG7NGEDvazkQFTLe25gikpPASVjElHvfGph3Osk9HmY=;
        b=hrxsi++roCYJ1Z1FXYPSxaiHcPAXYRnXk/nOWoo9IOPpmxdn5WRmZ9I/H8PC6dGJGB
         QedfeXmAjaekI7vv05bA/2MkkcgndxcKGm8b2d8cZt5BuN4dlkkbz5glRGklcXZK23+4
         W7Ql5b1MZ/qyw8vBenX87bAcni/CmGPyJJ3cfvkVA7XJGCXxfL7RrtWOy3LdQER/kokA
         TeksQJQsDTUGFjaaKwZ4fn24vHR605GSy6SwXSDfDjm+h6jn5WGEEV/k8TbxBndw0yUb
         6tH4OoWoKLGuZZYJDaD1jCzODBShctU5ouG5Tp/Ut362zYJMcAVeW7sjduhcT32N1TRN
         kbUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760389177; x=1760993977;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sG7NGEDvazkQFTLe25gikpPASVjElHvfGph3Osk9HmY=;
        b=BS3YaiPbrni9WDLaShTrPAs9GW8GWnSyfa9q+2koOROY4R40+iEDeMyophtMbEMLWw
         RU830m7QFMUkaaXAB5qemKgO1QuSOtQhea5wx5PRvi0JZL8sSOrhFWfyEGM//jpoGuKM
         chxc9f2SZLYlCM/U9m9M4SBGpVO7BZ9zWcY0tCUiE38tsSh77ED+Kg8Mgh7duOhFvkUD
         TwUSSgqu1IiVYAx1X/5jmQ7taRlNNYULgUZVfxB+5mt0zeV2++OTJ9CB44QnuPOubNxq
         H6Fuk/t8L+PAxAgrvL9deds/PH08+vN9bxyS5mZVlA/FsKDDg90Owxxu2bvt29KMPz3h
         hfLg==
X-Forwarded-Encrypted: i=1; AJvYcCUaWEYpMukZ/oZwj/5JrZLB0AH1/bZyfwjbE0hhLIzgmPSW2GnIMb1YybVshmav3LEEomw0rviNIw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxrniIPVLpn3zSwVJP2lXrS4Ays8xe6G+RUDjPSiqN1PiNtZTxn
	/UotNha2N3CjotwLpZ1zPSm8rEkTzW2ySnmSl5yC7lw2gwtJiHrzKfL6Uxzogavk0lnxaGnBlkt
	I5kESqnSe4Gu91O8PJhZv2NlApaAWNNrPYEpIhN00
X-Gm-Gg: ASbGncv/C1hLQa7mi9ppd8wF+UVz1bSG6NK+EZm0i76iely5ZAHGZsuEptysejRCe27
	EMNO1FZwRbDIIwCkrieqdWaYYnxJGM/4xU0tcS0DGc4h9d9f3KpzAIMvqxQXmX76UrVOZcHP1P2
	5/QZNMRiFOlc3Al36lt5sv5hdO2H/W+9m4a0gPiEDF2OFswsnenEMotbhx5ClnrCetsrYMY5oJI
	OrlFWQpSs0HPS9oJn03rbfviUpK4IHs0gaAadM7hwVsFcZ9KU6ttyMVmKV8Dv2xHnuyIIt1tg==
X-Google-Smtp-Source: AGHT+IFj45Vf6vX1bjTBB5Y4cqsAZeNKRI/eLafCHoF+c8jjTmaW/C5E9tyETRqfbRkVl6TZ+XnX8p5L2a31W/hIa2w=
X-Received: by 2002:a05:6512:3ba0:b0:579:f0fc:46f7 with SMTP id
 2adb3069b0e04-5906de89a6bmr6324643e87.56.1760389176718; Mon, 13 Oct 2025
 13:59:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007000007.3724229-1-jthies@google.com> <2025101316-rage-vegan-c380@gregkh>
In-Reply-To: <2025101316-rage-vegan-c380@gregkh>
From: Jameson Thies <jthies@google.com>
Date: Mon, 13 Oct 2025 13:59:23 -0700
X-Gm-Features: AS18NWDGTZv_Oy2h6qwDHrqgajO5V3yrBh2yGLcdRP13uD3jCB5MkJukoafZek8
Message-ID: <CAMFSARdQCDcB=tAehoaNkjW+Ctp-ULiDTtyTSfMJX9whYaW7sQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] UCSI Power Supply Updates and Bug Fixes
To: Greg KH <gregkh@linuxfoundation.org>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com, 
	bleung@chromium.org, akuchynski@chromium.org, abhishekpandit@chromium.org, 
	sebastian.reichel@collabora.com, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you for this feedback. The only patch here which is a clear bug
fix is 5/6. Currently the driver reports 0.1A max current when nothing
is connected on the port. I'll send that patch separately.

