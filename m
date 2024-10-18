Return-Path: <linux-pm+bounces-15974-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C589A42C0
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 17:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B63A2814DD
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 15:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBCE202651;
	Fri, 18 Oct 2024 15:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z9HavkLn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDCE20264C
	for <linux-pm@vger.kernel.org>; Fri, 18 Oct 2024 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729266201; cv=none; b=rgOWnfcen9h5GPTgj7vN4u9bwwbQ1HGHb/p0xtV6Efs7GrY2b+7xK/xY10mwQOzR3LW/IAQHTpBd5P6HzyqCjelnQlkxv8C2X80w/qjTjANpj+zKxyJUFOTaOC1GYCU0pi/iyEVBYLEFN4t5FeJD98G23krqTjbohFjDBlv15Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729266201; c=relaxed/simple;
	bh=c0Eoe6/nO4lN/XxFgwsBWWXoK2ooRSnbrUJPmSJTiYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W/q4HZQ0pdL2Qy03Ri26/R6ReG3sEWTQFrujoOaAbHA5/gNobnWC7grKjhyOCuaiCaepjkT5C+lpneOcHSRn7oU6ESfT9Vjj8aAXV3qCciOFV/0qQYGraDGxwW1+DurvosaOjTEn5swbMsTsvbfQtDWvHuBlX2oQTjok9rgTMjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z9HavkLn; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539e681ba70so21385e87.1
        for <linux-pm@vger.kernel.org>; Fri, 18 Oct 2024 08:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729266198; x=1729870998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNvrrma6BTw3zL2RctfT/cmV6V0njwbtezNVin6wtIY=;
        b=z9HavkLnqBdnMlcQBgaNWdRs1VuPPPRKuSCUAhWYtz3Jgfawyn7OpnKYZOBvpxauem
         hQOufs05xvtJPDv6pGqe/e+zPrrtgzAJ9XaTaV69DPSIF96fnkIxi3DLfuwQbHPATdEP
         rkzzXDrLefj3cT0WVbrVwFIq3I7kw3kuUDBVpfweeOFS9sdkrtfSeArLaDIUlnuzrl4C
         tW0foaI5kYT+smhUmHw+w3GneEPj5BC5kz8mGHEVEPDWaD8Nh5pzM5+BIYVX/eRFP/yY
         H+SyqSd6Rf6W4eRAZhSI/+DJS5NLQFqU+qYHG0/I2BCKPVxFXkr2LMWUf2/w9dqcLfhi
         Hc0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729266198; x=1729870998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pNvrrma6BTw3zL2RctfT/cmV6V0njwbtezNVin6wtIY=;
        b=Vc/4H2qKZatt1RUqPb2NsNZ3j/QABCKnXP6bjdBnGRG7uq5Ks9z4XShskisdIFqoSo
         8+2Hwo2970mn0/K9entLHDVXEe+hIOdM1NGffr1f5yERRCFdiqoKa6tfU0gb9Uo8OEuD
         b8ImxSKpN4ceEzSOASYJ1HTr0xZmwqy5hZtSYIAZY4WCQRJ2lEbD+U35160PtsrN3K1k
         IOUQDdf0DAlTcbzg/pAMjsFX+ovgf/78nhBX2AcaZOcwAGMNhz0QQI78RGX3oTm0+gWC
         8GCRNKMSLTNQJaDJwbrfNM5sytFfzLpFy00vNnMGRPCgxjtkvKzIyjdofZ3DBA6qEBsj
         aD8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXZAYw3eRwH0U89tOnY2djoiyoETEEsuV9WiHjmFKK2hh9dq8aTsqAE9BlHWHyoCAm359mxqf9N9A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxoQr5ooYDFp8/FZtqZYv8gAuewQDSIFVSR+fWnNK9ft2qDnXCW
	Jn+KMq3DTIDPI+VaAAfxq2sjeE9X8kugnqfMeTS5pGc843kB1WztC9DkQzSxynUZ3B3NlxF8NNM
	r3JZBizOKgJ9UX/P6G1k3dLPkPvBlZ7mtVjhb
X-Google-Smtp-Source: AGHT+IG3vlKjb4acLUJQrUf0wlFP+haGvVjOhpoNLq0EbhvWYHGGjdYzHwcPP6dx45ZVtSwlmUALpiqDUA+ttbmBIQY=
X-Received: by 2002:a05:6512:130b:b0:539:e436:f1d1 with SMTP id
 2adb3069b0e04-53a157591eemr413396e87.1.1729266197161; Fri, 18 Oct 2024
 08:43:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67124175.050a0220.10f4f4.0012.GAE@google.com> <671260bd.050a0220.1e4b4d.0016.GAE@google.com>
In-Reply-To: <671260bd.050a0220.1e4b4d.0016.GAE@google.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 18 Oct 2024 17:42:39 +0200
Message-ID: <CAG48ez2VAMZ2K8AvWL0UoEvFCaKEzVYbaJ=syezoXj9Y_P5UVw@mail.gmail.com>
Subject: Re: [syzbot] [pm?] WARNING in thermal_thresholds_flush
To: syzbot <syzbot+f24dd060c1911fe54c85@syzkaller.appspotmail.com>
Cc: andreyknvl@gmail.com, daniel.lezcano@linaro.org, elver@google.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, lukasz.luba@arm.com, 
	rafael@kernel.org, rui.zhang@intel.com, syzkaller-bugs@googlegroups.com, 
	vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 3:21=E2=80=AFPM syzbot
<syzbot+f24dd060c1911fe54c85@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this issue to:
>
> commit b8c8ba73c68bb3c3e9dad22f488b86c540c839f9
> Author: Jann Horn <jannh@google.com>
> Date:   Fri Aug 9 15:36:56 2024 +0000
>
>     slub: Introduce CONFIG_SLUB_RCU_DEBUG
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D14cc4c5f98=
0000
> start commit:   15e7d45e786a Add linux-next specific files for 20241016
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D12cc4c5f98000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dc36416f1c5464=
0c0
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Df24dd060c1911fe=
54c85
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1192f887980=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1417e83058000=
0
>
> Reported-by: syzbot+f24dd060c1911fe54c85@syzkaller.appspotmail.com
> Fixes: b8c8ba73c68b ("slub: Introduce CONFIG_SLUB_RCU_DEBUG")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion

This looks like a bogus bisection - the blamed commit was already in
v6.12-rc1, while the file that contains this warning
(drivers/thermal/thermal_thresholds.c) doesn't even exist in mainline
yet.

