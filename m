Return-Path: <linux-pm+bounces-24424-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C40A6CA5D
	for <lists+linux-pm@lfdr.de>; Sat, 22 Mar 2025 14:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D33D3BD5DA
	for <lists+linux-pm@lfdr.de>; Sat, 22 Mar 2025 13:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238FD1F9F73;
	Sat, 22 Mar 2025 13:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYKKa9Ns"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F50C77104
	for <linux-pm@vger.kernel.org>; Sat, 22 Mar 2025 13:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742650754; cv=none; b=VkNW0aiEysYPjHXYprzU0EK+jwEXApLwBKdZvcGt34dWOTFAHfiFMmQZLMLv23sGebAm/9MT/TWs6wUR9E2nRKMDgVOoBGwoJNHdOjXQajPdAeP6gE5lhe2EoqvlVOXbWZT0248EwQNraN16cm5+Zc0FofjK+co8D3HiZ0fwFno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742650754; c=relaxed/simple;
	bh=VwpdLaIVoP8rBOOapg5WFu98vRgR7tVu4SoMhNnnhr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BhkMxr0RHzG4ZOVJG9/4zcqsjp5s4Jb7G1H2vrdbEOBHHqEru3csSW714XebWWMTCdi88xiFELoCXlGBVCh3yUSaiF4yQsB0XtC/izOLEwP50aeSWNslT91kxnUrXPp2bMVjSZdGqBjVxO4aai67VMTe2yDZ3ETw2px2ZGd82D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYKKa9Ns; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac2aeada833so543964366b.0
        for <linux-pm@vger.kernel.org>; Sat, 22 Mar 2025 06:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742650750; x=1743255550; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8b8dRZM7EvfSn98Jtvim3OwIwvuq2pd1MOpf02mvdC0=;
        b=AYKKa9NsGAVKhUSuzvgO8QM83fU2LVAxSQCGKzeu0Tb6rOFhhljfR+WY1IqPzWu3KP
         mNGsZ4k8FgIEymz3R38LTTNqYJTGZiKS621ek0AYwYnhf1rT2FXtMHxN/Djv5qLt5RMc
         qbHJcwABVSJDICof8iFV5JFpmmZFrc7nF6WPv8qhNXlA1D0dsj4e0F5Otci5v36FgHse
         IYRqgeEE86f2acacVGkLaYpgaD8DC5nDkHbIwcOpuw7U7dLCTwB+vQreBIYP5PTrViG9
         F8xsQpvd+kkydzj03EMubZ4P5jpHXTyUtkUI5fV11VihaB+a1yaxP9hJ6QD75YxdtU82
         Lysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742650750; x=1743255550;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8b8dRZM7EvfSn98Jtvim3OwIwvuq2pd1MOpf02mvdC0=;
        b=iHV+w7V8lc5jdBsv1z55/y8bE++FzEwGLge6o9Do98ktd3dvjNjhT8HR4L4gqpNAyo
         cmkr6GiW8T+Pkvhl5yXQQ7y+KejZz1pAqJcy6Ad8mKpDoLyhwwocdQfq/sEVu+L0bwZy
         lg3xJmKcGNOpUS7aM2kF4l/rnWW2FrMpJI2+3b5mzAcqEjPX9+VmcQrdBCO2PJlQ57gE
         yZkDqLs/aJod2ojs5DFPkx6oE5qI5KCzpztDlfC9+/PmqFXbMFmbO+4C8RXhtgWiSYMG
         Ss0IN3fOZUNiQH3zIJGjCOLmTWrdUIwcMuMXZfovlXj8kbLp5DdEs0m51t/+ZiuBh6fZ
         r1lA==
X-Gm-Message-State: AOJu0YxKx7Nb4wgB4LmSyGrHYNyynjg/Rh9XWcLz4yfV0HQzg8lFU9RE
	+AU8+QIMPjGMrq6p9tOEDSfwA7FTSdKhgpb3xHZulzC83tWsyMPCv6YMt+BibPQt4nHQJCbXWZX
	ZpEadT+GTz6AA0hKIQfMd13av7d6aDh9+
X-Gm-Gg: ASbGncvKLNVbog/Rd+w8HzfPH8St0mBZo6kbBJAkrS+aJI+e9bpLI7xTaov374CT1na
	1/pMrPoJTqgvfOBMCPCMNVEi+sHijX2FTjHljQTtuVZEekPia2PJIARWKBEqZS8KQx2xYsvF+FC
	eq66HO4hw5TKg/MHtaLobSDe3G06jhRXfW1J7j
X-Google-Smtp-Source: AGHT+IE5b8ehVx0uXGtV6z+Aj8XkspjC2qFSbn7w3+LLozfK5T4m5qe9j69Me9LVi83qQdjgaY2GeC4aJ8rqTucpbJQ=
X-Received: by 2002:a17:907:c7cd:b0:ac3:eb12:a722 with SMTP id
 a640c23a62f3a-ac3f01199bcmr716096666b.7.1742650750272; Sat, 22 Mar 2025
 06:39:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAMvbhGRBhdz2RnReoGxDRM=bTws6s4qe5kh2nUqQDMRDYBh6Q@mail.gmail.com>
 <Z9NDz7TUIEflQeee@wunner.de>
In-Reply-To: <Z9NDz7TUIEflQeee@wunner.de>
From: James Dutton <james.dutton@gmail.com>
Date: Sat, 22 Mar 2025 13:38:34 +0000
X-Gm-Features: AQ5f1JravL7YE0W8Y9p73PDK2xveY8jS69OmXc3wjNhLmaVhmhz8CH0sEy25QIA
Message-ID: <CAAMvbhEOLmSm97rzLKgjNV=7Uy8UspPAS1vc4W3xv5F_b6PNaQ@mail.gmail.com>
Subject: Re: USB4 thunderbolt device suspend/resume problems. Unplug during suspend.
To: Lukas Wunner <lukas@wunner.de>
Cc: Linux PM mailing list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Mar 2025 at 20:45, Lukas Wunner <lukas@wunner.de> wrote:
>
> On Mon, Feb 17, 2025 at 08:44:19PM +0000, James Dutton wrote:
> > I have a thunderbolt / usb4 10Gbps ethernet adapter.
> > While plugged in, it appears to handle suspend and resume OK.
> > The problem is the following:
> > 1) Thunderbolt device plugged in. Device appears in "lscpi".
> > 2) Suspend Laptop
> > 3) Unplug the device while it is asleep.
> > 4) Resume the Laptop
> > 5) Laptop locks up, no stack trace, nothing output.
>
> There's a fix for a similar issue queued up for v6.15-rc1 in pci.git:
>
> https://git.kernel.org/pci/pci/c/876d4518a87d
>
> Does it help if you apply that small change?
>
> It should get backported to v6.14 and v6.12 stable kernels once
> v6.15-rc1 is tagged.
>

Thank you Lukas.
I found something that worked for me.
I found an infinite loop and adding a timeout to it fixed my problem:
E.g.
diff --git a/net/core/dev.c b/net/core/dev.c
index 2b09714761c6..580f74db8631 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6832,6 +6832,7 @@ EXPORT_SYMBOL(netif_napi_add_weight);
 void napi_disable(struct napi_struct *n)
 {
        unsigned long val, new;
+       u64 loop_counter = 0;

        might_sleep();
        set_bit(NAPI_STATE_DISABLE, &n->state);
@@ -6840,8 +6841,16 @@ void napi_disable(struct napi_struct *n)
        do {
                while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
                        usleep_range(20, 200);
+                       loop_counter++;
+                       if (loop_counter > 625) {
+                               break;
+                       }
                        val = READ_ONCE(n->state);
                }
+               if (loop_counter > 625) {
+                       pr_warn("dev.c:napi_disable() timed out\n");
+                       break;
+               }

                new = val | NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC;
                new &= ~(NAPIF_STATE_THREADED | NAPIF_STATE_PREFER_BUSY_POLL);

