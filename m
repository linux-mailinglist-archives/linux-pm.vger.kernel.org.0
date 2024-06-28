Return-Path: <linux-pm+bounces-10161-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAE091B5B9
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 06:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4B69B21A99
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 04:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3F71F95E;
	Fri, 28 Jun 2024 04:37:06 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E4722339
	for <linux-pm@vger.kernel.org>; Fri, 28 Jun 2024 04:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719549426; cv=none; b=j+b72CyGkwZhZCUcL28YfxenMamU9Px/yZIrWW7/m8ZFqEtB+ioLSb+xYqgQY68WutMGypCDtOOmUCWlxiu/JnVpzdWNIhTTCN5c3vdmhzAt4Nzt65NqVUbfi9QBsYpH+GmrqmJ28lnC4rD73PKXt78gZnegP9GKLxg6noG3jGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719549426; c=relaxed/simple;
	bh=xlslSczj1zugpAH2Zf4cJcl/RLaeD35TKHxGBuPhLgY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=rSE7i0sOug5jKrffJFg/rIcRY20gXcFqSdXP7sMtxzjuTCV0cv7XXZJ2WZlpaAiZQnxq+Rxlxd+YtHGnpVhwBM6fJIszXW434v5Gsv1INBonZDQcKNdf+gqo6/hjjHE93PcvVNPLXHkfDzocmkFaMIkO2GysPkwQPJYlyxCK4Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5c2011716a3so71641eaf.1
        for <linux-pm@vger.kernel.org>; Thu, 27 Jun 2024 21:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719549424; x=1720154224;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=22xO8xT34dKWqYDtz2gdjOhGIEYlpoD/1RmodBVegcc=;
        b=YZiDDTNPACYQ2v4aQwYUivtQ9ek67Wmll4rGgVVTMLFBuZYiFXH0iZqVsG6GehRkVa
         JS4vpLvv9IMj2drq00JBSl+PImzQOgdoiJkBjb11rUXi29Na+2sKBZ61b6OkccfPzYgI
         NIL0QqCGjYnOUD0lRhfepQ3KRPs46W/kDuQqrw6lkAwa3ocG+pK0HG2OEVTSsMzKTguH
         QxVg+Acozy3kfpm5th+KBGFGIjE1F4g6xeHfNt6rfbSrqmJRoJ0tIWlxBVK0RotR2ar5
         vo9uAbSt2FszR60j0haL50Ec4oFOhnPTokCKzDHIXEBxtWMOHo88+GGd89EGpb+AkjhZ
         p/pg==
X-Gm-Message-State: AOJu0YwWkEloxP2UW/svnp9nzgykXOrC9t4JDT64gxtshosbRWWLjqJs
	a6llTPMJEpm0pwQF1EVwu0mHxgYcbmcQD+YJJD81SKP7fDTXtWjq22QnGSZvU9y3WvuBccOdwO5
	m3xfodmUFEUTNqJGkCR4hDNGOPi5fjwgl
X-Google-Smtp-Source: AGHT+IE+VelaegCxqHuBV3ZPfgFykBV+0O8fUfi67AOFTU2zgqFu0C2Q5U/T+pLo8x63/nzon7WK4Ts64gBEXfare60=
X-Received: by 2002:a05:6870:470e:b0:250:756b:b1ed with SMTP id
 586e51a60fabf-25d06c0b974mr14217082fac.19.1719549424262; Thu, 27 Jun 2024
 21:37:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Len Brown <lenb@kernel.org>
Date: Fri, 28 Jun 2024 00:36:53 -0400
Message-ID: <CAJvTdKkkG-xe30hMorCYzmB-gJAZ5Y1ugQPs8ma=8b3DHGm2Lw@mail.gmail.com>
Subject: [GIT PULL] turbostat fixes for Linux-6.10-rc
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

The following changes since commit f2661062f16b2de5d7b6a5c42a9a5c96326b8454:

  Linux 6.10-rc5 (2024-06-23 17:08:54 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git
tags/v6.10-rc-fixes

for you to fetch changes up to b15943c4b3351173d5f3b0d87362d2994a89bb66:

  tools/power turbostat: Add local build_bug.h header for snapshot
target (2024-06-27 23:53:27 -0400)

----------------------------------------------------------------
Fix three recent minor turbostat regressions.

----------------------------------------------------------------
Adam Hawley (1):
      tools/power turbostat: Fix unc freq columns not showing with '-q' or '-l'

David Arcari (1):
      tools/power turbostat: option '-n' is ambiguous

Patryk Wlazlyn (1):
      tools/power turbostat: Add local build_bug.h header for snapshot target

 tools/power/x86/turbostat/Makefile    |  6 +++++-
 tools/power/x86/turbostat/turbostat.c | 20 ++++++++++----------
 2 files changed, 15 insertions(+), 11 deletions(-)

