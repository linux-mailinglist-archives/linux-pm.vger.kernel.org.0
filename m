Return-Path: <linux-pm+bounces-6065-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BAE89CBF4
	for <lists+linux-pm@lfdr.de>; Mon,  8 Apr 2024 20:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7738B2A5AA
	for <lists+linux-pm@lfdr.de>; Mon,  8 Apr 2024 18:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9794713D28E;
	Mon,  8 Apr 2024 18:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T/PJAksr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB6B1428F3
	for <linux-pm@vger.kernel.org>; Mon,  8 Apr 2024 18:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712602104; cv=none; b=XHcJghBBrYlr3U0BlsN//jD9WI5hmHimR3tHqj2Cy7/N2jYY1877mPNwLISFCNuxGhP5pVVLMeOaHUaOhL32ZkLarteQmdBIcyLy/3REkgcqEjBKSrtMhCDaJnFKPikyNNpryOa8+64BUq1ZM+ddNh/dwZVme/5QwAe153FHHM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712602104; c=relaxed/simple;
	bh=Kl2bV0AiaOmyjkF4Qu87DkbXJtzTDw/NlaLnyZgvKtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hnHx2cJUVNJ+yR3IViRAsX5EAVUdq0bOzfaMEchWjfTfMIYULVQ2PwgQ64OnzTZrBnd3pSbeCAOXld03ybfqM5sg4M9E+LKdkTxMJNu79FC7unwBt6DIzBa/uaQDjubbIqo1sOavLKIxaSXv7xe4JN9EiE6nmxn6WRVDG9N7WnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T/PJAksr; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4154d38ce9dso13885e9.0
        for <linux-pm@vger.kernel.org>; Mon, 08 Apr 2024 11:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712602101; x=1713206901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KeUwS2HR95cbFJsuix6HTY0DdZiDL+kQ9VooBNfr4w=;
        b=T/PJAksrg0cxYJdzQ4QRBPov4HLx0k9r/3vggO1GInrxQSj+Dz/wzV7GBVeBh/xiKn
         2ZXsZBaNTVCTN552GCFmuGLbj2DMW+GMMhsO3ZyAufjWbwAOxqiV2MdnOXP9sULMO5ne
         l3UaUrsCDFUg/87Yu/O5rjlnME96TmyLH4c6ENqdCuX+PCmPGpory+tegt/iwgTfN6F1
         GhnKdeVehirtzkknflg7jfdfMcFteMgEbk/FMCriENgFf4R9FsLnxbwBgnE43lhbzUs3
         SG5QCcS06jvzL0JinQH6v10urrV8BC1hz/H0Rt2AiCTvq9q4AF/Vu4Cqaw53vS6bpM95
         4gFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712602101; x=1713206901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+KeUwS2HR95cbFJsuix6HTY0DdZiDL+kQ9VooBNfr4w=;
        b=kR+gLcPUSC3PvsefblNnki+6EirpgqO9Zf+OFiZA016ZzORyaV9lRp7Wl605ddbqvg
         ZXQ0UAtk6NXP/8r348nAhqkkJK8oeQ57oUBXCr4wP9h0dkTnD2XNjJDf4nQhv8uszrbF
         sZXhOAXhpNtgg6pCANFv/fRfjlOMkOuYikaeB/jmZ58QzlnG256jh0JGdk8g6Hykt21p
         ziNePiAaUv2sQRonvtiqULqvWbC64b1QZzcsFsgJzE6IhkeSVHvyy+dhF5MDbKFc3F+f
         r4ttAPsAkxfu4Z6Tw5djOx4vkgpCHzb6M++s4MiE+c63S6SGDsqrIaj0Z/JUfRy4RNWk
         tS8Q==
X-Gm-Message-State: AOJu0YwucAxhcirItXdew9Q9fhl8VcPV51yOEN2C1S2yzayZzAP/T+NA
	e/C2SmiXmWHBs7JXupXr9/67SyOZClq2QXjkU9Sl1zY5K8UVhhlVCQ4ENTillbmbdEdKUm+AavE
	FYRyPbQdmZeKoyM5sdUD+c8pyNGyC2Ayu5KQ=
X-Google-Smtp-Source: AGHT+IEyu7AnmtZjjjCb9OOi1UFs82xv80Svm1cuQCPWzBkiQ9MqW+CmcDfyeQ72PPONITuch9xz6Wgz15RM9onRzB0=
X-Received: by 2002:a05:600c:4f8a:b0:416:6d90:38fe with SMTP id
 n10-20020a05600c4f8a00b004166d9038femr19772wmq.4.1712602100965; Mon, 08 Apr
 2024 11:48:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220710164026.541466-1-r.stratiienko@gmail.com>
In-Reply-To: <20220710164026.541466-1-r.stratiienko@gmail.com>
From: John Stultz <jstultz@google.com>
Date: Mon, 8 Apr 2024 11:48:09 -0700
Message-ID: <CANDhNCpAhtgdwpSUTJ2jo2J5L6rHzQHVB9q+kkZ3ouTt12b-uw@mail.gmail.com>
Subject: Re: [RFC] thermal/core: Disable uevent messages for cooling devices
To: Roman Stratiienko <r.stratiienko@gmail.com>
Cc: linux-pm@vger.kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org, 
	amitk@kernel.org, rui.zhang@intel.com, linux-kernel@vger.kernel.org, 
	megi@xff.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 10, 2022 at 9:40=E2=80=AFAM Roman Stratiienko
<r.stratiienko@gmail.com> wrote:
>
> During suspend, the big CPU cluster is turned off first while a little
> is still running. This forcibly unregisters the cooling device which
> sends a "REMOVE" uevent to all subscribers [1].
>
> In case userspace netlink subscriber has set the EPOLLWAKEUP flag, a
> wakeup event is triggered that causes suspend to be aborted.
>
> Without this change, suspend doesn't work on PinePhone PRO with AOSP
> userland.
>
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/c=
ommit/?id=3D5c238a8b599f1ae25eaeb08ad0e9e13e2b9eb023
> Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>

Hey Roman,
  I wanted to drudge this patch up, to ask what the current status of
it was?  Is there an alternative solution that you've been using since
this was last sent out?
I've heard of some vendors working around something similar, so I
wanted to see if we could get a common fix upstream.

thanks
-john

