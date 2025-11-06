Return-Path: <linux-pm+bounces-37565-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E4FC3D646
	for <lists+linux-pm@lfdr.de>; Thu, 06 Nov 2025 21:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A56C23B4D73
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 20:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397022EFD80;
	Thu,  6 Nov 2025 20:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCqxMFJv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E3C2ECD1D
	for <linux-pm@vger.kernel.org>; Thu,  6 Nov 2025 20:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762462104; cv=none; b=cBSb0JGU6vlNS/fV4lSiu+S/Fvmp3mrnGqLQncLGLabQJx5aXqnM1tfrjrMtf3Hz2YKfjlJIZpU3s0XvwcDoYsgktAlkzVqDq36A8BnS8JgxK65IXyML2OG6XUUdSi26yUf3ZYqFjhZjDECQB0MN7bAv7cL4JF/a+PLBfKjgiJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762462104; c=relaxed/simple;
	bh=dr005dpLkas4WnXviQ5B81ti/H+qgkZ2bSDfzBjRc9Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k37l00Lu6XIRV3VELz4272f5vROKH+AT7E+2hUZNMN5yqoa38GdPXxzvSNU8+SvyKeO4PWy9AMwU2ELWeezKGVepTLIH6QTLFap/V4T52zN1KwbrRIVBiukCHtx2Jdsx2iTHkgLr8IPkVtpV+spVb61Vb/7f7GtdqouArFnlwRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCqxMFJv; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42557c5cedcso34406f8f.0
        for <linux-pm@vger.kernel.org>; Thu, 06 Nov 2025 12:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762462100; x=1763066900; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dr005dpLkas4WnXviQ5B81ti/H+qgkZ2bSDfzBjRc9Q=;
        b=lCqxMFJv92aCXVm6N/U68daNhGgIenWkH+orIEvPjyWaA5WOZF81IFUuui5hbfnaN7
         Cq8lAE2JII80yUz0sK5pXp28+QmqkhZeGnQPk/c7ZH4mLM9bRVPq26vYYjDha6UDgnvD
         T9EEUDyP+dHPo1KRPQIsb0ts95Ouiw4cMfmVdAkOmphATk38/TKNXrwALuIjZgYivKXE
         eodZPdUPFTjYND4ZracB6U74SYllQyLK9ChA6T2S5V/iiEksWkzFzC9bwbfV5qGvnZHC
         2SOlj5rYWO8Vmv/oE9W9jpTl28WXNWTXS2G3Am7CHqEi6Fw3ak+k8b1DZake0y6Szg2M
         n9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762462100; x=1763066900;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dr005dpLkas4WnXviQ5B81ti/H+qgkZ2bSDfzBjRc9Q=;
        b=HLdaFAKDuefn8jUVb8EiFev8HLyct0sne1i8zGcWtjRCbs8/t5TWaACmqqE7J9ruro
         /tGWwDx60TXiFFwB8my0InHnZt44HNrsfqXrOcY9PuFHJPUjavMnwfNfV5I+02kqCX0m
         qes8zHUs00NOw30kXzToX5w2a3G5pDwAOOzPgnaIREKCzb3ARTXy97MBDTUUA9e7FMlZ
         AAUiuSLQpD8d+AM6IDZFNaBI9mfLzCC8zdon3h5FgTxTCL8YZpywkYhFGaB0qWNYPt6v
         +BQ04vXBd5z8L7E9N9LQxA/taJrVxlSGOlWrTf5U1tFL6JNHw5NctXmJz2QG4Qy+QHHo
         EklA==
X-Forwarded-Encrypted: i=1; AJvYcCXXaBRthOKiyiMuBU4ZEWoOqdgzdSR3tAuG93Rf1k8d5dQ/VTAsPSibtRuZFYhCzkpbdEHRCpKSZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQLzjVxHcB2LDS57cGPf6lp2Yfs+pmRiTU//z4N7s04M2Ks81x
	GcQGrOUPJ4XZ6EzwXjR0nkPvLd3gbDH9sCiPNIO8sECHiPc/Z+q3wM1mb31LX+WMWe4vVg==
X-Gm-Gg: ASbGncsIPSTBAi4Au6YFSKa8aFsgDOLkWnkczHepPP92zXAkssLHVipkUTZTIYobocH
	cTYpzzR7YV5gG0PCqeXImOY5nq1NURuMSYzoHjXnuDhhB3Vlagm4cDbkzYgBaiqzxH1lDjU1Wd+
	CJT6SlghSMThv+Kzc8RtYzaO9Gxv4yksFUUeKd4CfZqlCSYzzRQbQuPoPzKUcnBD0DwtExh7D8V
	LF1Y1TdQlsolk+cRHZ1rp8HIo4HrNZY52Bx/Oddxo61TtOVqztjIlGi/o+iJM1upl7bVvUqY4/d
	A/dXqwpZtxWx6QQTR3IzBdsnjsCHLn74dPRZDCGS6MuAWGRLLdSPUQADxQIjH2H/tO+0Ba5lnZt
	hBQpH8KmpWhNSNf/vuHJymBXMd3IrjoMSJny92c2UdE6CQN5aLyc77Rl9eiiZ7N5dbrBJDV9b1W
	+8VhQ=
X-Google-Smtp-Source: AGHT+IGJNG8/keYfKI9dKif++vzU5y4adAef+TqmmN4tAlwl8eWO/j7FK5nF/35ZQEdz4Asj62DQyw==
X-Received: by 2002:a05:6000:1788:b0:427:a34:648c with SMTP id ffacd0b85a97d-42ae5af3dccmr573308f8f.58.1762462100307;
        Thu, 06 Nov 2025 12:48:20 -0800 (PST)
Received: from [10.245.245.6] ([192.198.151.47])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe62b28asm1120660f8f.6.2025.11.06.12.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 12:48:19 -0800 (PST)
Message-ID: <53abc1a10b01d9298d3bd3200b0fecec37b03bce.camel@gmail.com>
Subject: Re: [PATCH v4 0/4] Sapphire Rapids C0.x idle states support
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Jon Kohler <jon@nutanix.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM Mailing List
	 <linux-pm@vger.kernel.org>
Date: Thu, 06 Nov 2025 22:48:17 +0200
In-Reply-To: <2D60A950-95E4-496E-9E25-3928E9D22B7B@nutanix.com>
References: <20230710093100.918337-1-dedekind1@gmail.com>
	 <2D60A950-95E4-496E-9E25-3928E9D22B7B@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-20 at 16:52 +0000, Jon Kohler wrote:
> Hey Artem, Linux PM list,
> I stumbled upon this patch set from a while back, and saw that it looks l=
ike this
> was the last swing at it. The data looks compelling, was wondering if the=
re was
> any appetite to pick this back up?
>=20
> If you=E2=80=99d like, I=E2=80=99d be happy to reignite this work if it h=
adn=E2=80=99t been killed intentionally
> to take it off the collective plate?

Hi Jon,

I almost forgot to answer, sorry for delay.

So these experiments were done on a pre-release SPR, but at the end of
the day, it turned out to be not worth it on a released SPR. So I did
not continue with this.

Thanks!

