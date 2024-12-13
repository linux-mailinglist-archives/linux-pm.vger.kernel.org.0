Return-Path: <linux-pm+bounces-19220-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E81C9F17B0
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 22:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3027516BDE4
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 21:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF09191F6C;
	Fri, 13 Dec 2024 21:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XqzXrWNV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668F718E02A;
	Fri, 13 Dec 2024 21:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734123686; cv=none; b=gbPv8Y0c26O0safF7NYng3NMIQpZfvzp0FDmX2A/fZQEv1Nv3dRSerxmNBCPdOKe0tPlCI+5eATYDDGUxke6A7V6YhaJ7wUtzsGxBfAY3oQGMdN55kOhzY+5M/RJosWn27zM3F2pByTPlK7PkP6bpkz3mFRSF9B3foRIdAs4HpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734123686; c=relaxed/simple;
	bh=oKMygOFYsexp3cwkco1B1/KvI29u9MdaTXnvDS9O8bI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=aBBfOZ7BB3tZB0IqK+t5w1lUqWoAwWNkQL+7Oxz+vviy3vf3kfRtOH0/R5PBWs6Ntl+HIgi6Fje9ABWDxFBw3UHkHEsh5BWtyMEPAGebmzbKkZg0Pfum8V2uwolh1f3f7uZLhTFOPWlp+4mA1mg6oWPjmupIVkpLUUdhiuryvHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XqzXrWNV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0710C4CED6;
	Fri, 13 Dec 2024 21:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734123686;
	bh=oKMygOFYsexp3cwkco1B1/KvI29u9MdaTXnvDS9O8bI=;
	h=From:Date:Subject:To:Cc:From;
	b=XqzXrWNVWC4bvj0vI6ephyicK0TiUAvgeLAKW1hUHimpRDoQqztK/9nqoR5Tm3VEg
	 Z+z0JWatI1xXFph5YZoFxllcJ6iARVz4+Qi+RGxXqGW56QMxyhXtPvj4cITEQeIXXO
	 gGKrlulLeg3e8D12ZoTqwfA+LoshIqNWWEfLkyzzVki4tryRu9WDB3fta4QuyVQSqJ
	 A/ttI79WqPkRKqV0XA8TVhj6vbnG9Kn2diselpNTSk6RBPRm0LBsWgvTggKESZAQUx
	 20TQrUxOjFr8HIZyKCmRaKU5Mj8xRKWz1Bb96K7WZfbZaGiMRZINHxo2CcNZMrhGaE
	 XP+BarC6/JnPg==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3ebb1652729so194969b6e.3;
        Fri, 13 Dec 2024 13:01:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXcwdRboeUIwHktFYc64Aq/+nIi7OmcGFrPDro6Gd3UuXk1rC1prIjWPZt1TW8sr4+exoTKlRJw9pDC8j4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGl8y0TwrnEkd5qrL91MiuH6DAWw+MVCo9E+/EqhHLv/2uf+AM
	Lo5WAX3yKD98PtPNunOhFVwQw5PRUAVhWBasp7dIVxF/7LMBynokHR1Vq8wYE/ZAfVK0fWLItVX
	dpTJT28ArumArQRz+BEwbdKbi9kk=
X-Google-Smtp-Source: AGHT+IFB925/Rt8uMrm9uakaCSdGA7UoukSaGpKHjbgnLeev+m10FoaZ5SM9qx+7M3yGAisCWdrZwNm9nAO9EzE0nGE=
X-Received: by 2002:a05:6808:4445:b0:3eb:922f:9031 with SMTP id
 5614622812f47-3eba69a174bmr2402054b6e.40.1734123685280; Fri, 13 Dec 2024
 13:01:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 13 Dec 2024 22:01:14 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g-ZThRsRm53qm=JvYdGsXxtMq1NkDrR5qd65qN8kjw_g@mail.gmail.com>
Message-ID: <CAJZ5v0g-ZThRsRm53qm=JvYdGsXxtMq1NkDrR5qd65qN8kjw_g@mail.gmail.com>
Subject: [GIT PULL] Power management documentation fix for v6.13-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.13-rc3

with top-most commit ccb84dc8f4a02e7d30ffd388522996546b4d00e1

 Documentation: PM: Clarify pm_runtime_resume_and_get() return value

on top of commit fac04efc5c793dccbd07e2d59af9f90b7fc0dca4

 Linux 6.13-rc2

to receive a power management documentation fix for 6.13-rc3.

This fesix a runtime PM documentation mistake that may mislead someone
into making a coding mistake (Paul Barker).

Thanks!


---------------

Paul Barker (1):
      Documentation: PM: Clarify pm_runtime_resume_and_get() return value

---------------

 Documentation/power/runtime_pm.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

