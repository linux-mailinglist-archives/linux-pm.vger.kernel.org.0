Return-Path: <linux-pm+bounces-38637-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D93F3C86132
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 18:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E700D3B277E
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 17:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578DB32D0C3;
	Tue, 25 Nov 2025 16:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dTyjMtaa";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UNS8YvUH"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989E432C322
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 16:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764089954; cv=none; b=adyzuBgyOCHy9qrp5Pri1u7VcUkUX5pDiMWU4jXObKpZ8RuTVkhKRUnNbexP3AIH/pea4gViTc77rvTG3ECdPm8hwjCXV1yXFsdcPGX2D/jX7VYHxZPRoNPX+8oDV4ftxayCRpHzItVdphFqfhuYZZz67+oc7lxaWUTexM3pdrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764089954; c=relaxed/simple;
	bh=QrCXwTVbTY2L/QXOdA+AJKifzsbPegD16vH5IBkdGJg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NhODZRyvgBcWmd6ep3mPETCH4UF1br75ghMJho6XW0vmpktnbRiaZ69qrC3Hj+LQXA/yLQJSAHs5mbddRIqsV+a0nQgquELTKMzSyj0t7O3WK7ydEKGsCee+aC4FqQPb+vMs4q2EJ1+bbH/0Hn8e3glm1GCEBSG85gh/gcSawBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dTyjMtaa; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UNS8YvUH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764089950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hG/yosQtNPsaLgr5tkw6oyaa1Fhacq6iGIxAKL96B5c=;
	b=dTyjMtaaxJox4SfXepcEJ5Jbtj3IrGV+KEv/zrWKrR7L9N/401SgaI/DtFyepKaUFcM3zi
	lzZjiePPlj6ue5bn8+g4Dc7WFmOhKx2IvZD5ET0rF9rBYj0NR+WKxq+g7nBh6ARIeyvnBY
	LH6vqIuS9s43LbAUCdG4GTs7QeZn4Fc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-tZ9yC7j3MXenfVgtojf_Bg-1; Tue, 25 Nov 2025 11:59:09 -0500
X-MC-Unique: tZ9yC7j3MXenfVgtojf_Bg-1
X-Mimecast-MFC-AGG-ID: tZ9yC7j3MXenfVgtojf_Bg_1764089948
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4779da35d27so68495705e9.3
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 08:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764089947; x=1764694747; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hG/yosQtNPsaLgr5tkw6oyaa1Fhacq6iGIxAKL96B5c=;
        b=UNS8YvUHTYtcrPkW7zJRWp51Oirzp785bbqqoJdf66vfc7LAIXwMDDERXK43YgaZ+q
         Q6UbfgLcebAsxTTQ6KjtzqZ2EP5UlcBvyuRhze9rp2S5X2yVYseYtgvzeObkrVDogsPN
         m7OEZF1AS3Kuqk35U0YXLfnXfG+OnH6YnIXsuVxRPuQT26C/TwE5zG/NGt0pq7oynTEy
         Q7RiW3L/bM48PrGDUW7GutP39roAW+BvizuyVL6jIx9KnU1sDGu0VwGed6o0kveWEPHg
         ZRjsPjd9OmpsHZ+5kZUogt6iu6xt1mDrliNCRrZNI3ZBs6tO/RHR6B5xYHahVEzVMKv4
         QZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764089947; x=1764694747;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hG/yosQtNPsaLgr5tkw6oyaa1Fhacq6iGIxAKL96B5c=;
        b=qiNTzRAFVdf0HWO6ZN8z9It6XvXiMOQO+fxAxK/yqDIt91qZpHXbMXLuvsf4kvOUOU
         PqPivgYPeybTbDStw4OOxCkmdsjhtJqy10g0vkRAmHM095TYacO49abJhSb48Vmfm1mZ
         QPoCJzLWOGGgcqqqHOG8+AsA6dG1aik5cnU1xHfT80bqOLdmv5+gEBn0fpv4qk29+UJo
         9FdTHfhV72CE2NWjlhGhePV/bPkKmkQ3XPiRuBt+0p6u6crxIyV4SVXX+sJPeKXaODX0
         0xHYNmrCeumdGr7DCF1TTgLwIFcUqCCwUt/GOl0cXx+ddCdO0jXjfYUbxqglNxK7CaSb
         TAJA==
X-Gm-Message-State: AOJu0YwYcJz+XT/XKAiD9upovp2WHEGKSIiplnoTNmLH4cv843FmFCW6
	kfuP8/VaRmZGylGJOYTjXTj+p+Cto0gj8wFkq0ieTdbcj4BATKodnD6IMv4RSuKW6/rApeJO10T
	K/AL7TUpiXYKCZ+b8LmlwzWRjQKeb8UjnmIqpTgnHyPWZAlgYSQifqkRXElYg1UNikuG4JkIIrf
	bPwgkTKui8l0PitvNQJtEljJoQc+v6XFCXhyU9PnWcLPnN0OIH5w==
X-Gm-Gg: ASbGncuYC3a6djFDi0sXibcewAbi0KEBoqa/sLnwQJu4zCbISMR+ckP/RllIj1os8VS
	DSAdMN9nzgwKRd35wqQi8DRQv3IwQp1TkGrzF8kDScujDRHhgyK7x7DvOgNcEfwpBsSXho5CDz6
	k2L8m8W6CO5przY4fbDXgM50sN72FdmA0iP1WMlg2CM9wEB6qU51uiu+D9M8owgO8ewy2xEVsBG
	pQnTXTJ89E+9SiW2SkPavQg/ZBO2MiI7p48AbQShrskuJr5TuShbrMS8b9CdU5MT+vzzgZfV94p
	Hm6a1EKWw47Z2bjaO1TAnFHq+vhaztFTgF7OeBp+p0ayi/yit8srEP551BNAJsTuv38h3JV5q4A
	vbtIdompK/wPvslJJK6Hs1xqViaRQi9jwn4PU12TuyCOXv6ohDxH0pfQ=
X-Received: by 2002:a05:600c:4f49:b0:46e:761b:e7ff with SMTP id 5b1f17b1804b1-47904b24957mr33441345e9.28.1764089946806;
        Tue, 25 Nov 2025 08:59:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfZ6NgVrVjPGwjj83mk0cuZy70V+eAj/GkF9EsNDbbjKbkEF6o0Lstb1Ac7PYBzJ0qoAHtSg==
X-Received: by 2002:a05:600c:4f49:b0:46e:761b:e7ff with SMTP id 5b1f17b1804b1-47904b24957mr33441015e9.28.1764089946293;
        Tue, 25 Nov 2025 08:59:06 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-2-99-207-158.as13285.net. [2.99.207.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790552c3c9sm21068055e9.0.2025.11.25.08.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 08:59:05 -0800 (PST)
Date: Tue, 25 Nov 2025 16:59:04 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
Subject: [ANNOUNCE] Power Management and Scheduling in the Linux Kernel VIII
 edition (OSPM-summit 2026) - save the date
Message-ID: <aSXgWOmJZnvEFYaH@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Power Management and Scheduling in the Linux Kernel (OSPM-summit) VIII edition

April 14-16, 2026 - Arm, Cambridge (UK)

.:: SAVE THE DATE

OSPM is moving to the UK!

Please note that this is a “save the date” announcement only.

Given that the Linux Plumbers Conference 2025 (LPC25) is scheduled for
December 2025, the call for topics and registrations will open in early
2026, after LPC25 has concluded.

More communication and further details will follow. Stay tuned!

.:: FOCUS

The VIII edition of the Power Management and Scheduling in the Linux
Kernel (OSPM) summit aims at fostering discussions on power management
and (real-time) scheduling techniques. The summit will be held at Arm in
Cambridge (UK) on April 14-16, 2026.

We welcome anybody interested in having discussions on the broad scope
of scheduler techniques for reducing energy consumption while meeting
performance and latency requirements, real-time systems, real-time and
non-real-time scheduling, tooling, debugging and tracing.

Feel free to take a look at what happened previous years:

I   edition - https://lwn.net/Articles/721573/
II  edition - https://lwn.net/Articles/754923/
III edition - https://lwn.net/Articles/793281/
IV  edition - https://lwn.net/Articles/820337/ (online)
V   edition - https://lwn.net/Articles/934142/
              https://lwn.net/Articles/934459/
              https://lwn.net/Articles/935180/
VI  edition - https://lwn.net/Articles/981371/
VII edition - https://lwn.net/Articles/1020596/
              https://lwn.net/Articles/1021332/
              https://lwn.net/Articles/1022054/

.:: FORMAT

The summit is organized to cover three days of discussions and talks.

The list of topics of interest includes (but it is not limited to):

 - Power management techniques
 - Scheduling techniques (real-time and non real-time)
 - Energy consumption and CPU capacity aware scheduling
 - Real-time virtualization
 - Mobile/Server power management real-world use cases (successes and
   failures)
 - Power management and scheduling tooling (configuration, integration,
   testing, etc.)
 - Tracing
 - Recap/lightning talks

Presentations (50 min) can cover recently developed technologies,
ongoing work and new ideas. Please understand that this workshop is not
intended for presenting sales and marketing pitches.

.:: SUBMIT A TOPIC/PRESENTATION

Please consider this a "save the date" notification only. Information
regarding important dates and how to submit topics will be announced in
early 2026.

.:: ATTENDING

Attending OSPM-summit is free of charge, but registration to the event
is mandatory. The event can allow a maximum of 50 people (so, be sure to
register early!).

Registration is scheduled to open in early 2026.

While it is not strictly required to submit a topic/presentation,
registrations with a topic/presentation proposal will take precedence.

.:: VENUE

OSPM26 is hosted at the Arm Cambridge campus (in Cambridge, UK), in the
lecture theatre and breakout area. We appreciate Arm's generous support
in providing the venue.

Although the event takes place on Arm's premises, it is fully
independent of Arm's business operations. The summit is organised by and
for the open-source community, and everyone is welcome to take part in
an open, collaborative environment.

.:: ORGANIZERS

Juri Lelli (Red Hat)
Dietmar Eggemann (Arm)
Tommaso Cucinotta (SSSA)
Lorenzo Pieralisi (Linaro)

http://retis.sssup.it/ospm-summit/


