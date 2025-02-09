Return-Path: <linux-pm+bounces-21602-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 771C3A2DE34
	for <lists+linux-pm@lfdr.de>; Sun,  9 Feb 2025 15:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B7F63A60B6
	for <lists+linux-pm@lfdr.de>; Sun,  9 Feb 2025 14:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9581D90C5;
	Sun,  9 Feb 2025 14:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSFPuqkr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C94E14A0A8;
	Sun,  9 Feb 2025 14:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739109891; cv=none; b=omJBuBS7ZvFu0Uyj7E5QokBpcjGbTSAADxX57/1v9BH1m2Gma/yE74QEhUDBbXoL3iDtOOaTC7YGHBuIlFQI+50k+G3O1jGY/FdtJ1EETllFX3gb+8OQegS9Z3djXo6Xuvt5pPdnWNvSffGFrOccceUyDBVjJqWaWIyhWW7xHws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739109891; c=relaxed/simple;
	bh=qI21Q5zO33j93WU5qSHhhcQYc+eC6aCL10g4Ll7hy/I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=TDTjgX23U9taGVkhfkNi7gEPCDo848q8iauKQJsm+lPtWDXbjhH8D115aAztStZ4mQUPYMvNGbuaxGqNkj/KW4n6sYAA5s+hqLg2bJviv1w/JR4C481VHT7ln/uZTLG3Ids+D2AgLBpoLCtwacY28NqsG/b6B67qDlzQLTaP6bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSFPuqkr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC479C4CEDD;
	Sun,  9 Feb 2025 14:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739109890;
	bh=qI21Q5zO33j93WU5qSHhhcQYc+eC6aCL10g4Ll7hy/I=;
	h=From:Date:Subject:To:Cc:From;
	b=TSFPuqkrXU2laJf2EPZdHcA/Ky4lxVz4GtIsFdYBTxY0/jMEVLAnGmnhSMGe0wdW7
	 CsaudyX3NfKsjH9iGDX3mnXYZK9Pr8QeFaZyOEtsQlC0VQ1bCoduSWgomPuqp198BD
	 Eh/s/0LddmVaAqCNB4aq5WYnih4ngO+vTI///n4vtbhBdtqrmMeqrEWNfgp5w5LBrk
	 +HHwBJ/AgtorLzodHWa25FcsL4z3kDlXQAn7LzlQfoCWtdVPNNuf6jFRQ66bFNctYv
	 DPYGXb7DKIDUI9AJDHO49cWOOnF0Inf3EqtobWUE6rIX2nImjewuz0etNdgNxzygLG
	 5zdQFPVMPqTHQ==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3eba50d6da7so989748b6e.2;
        Sun, 09 Feb 2025 06:04:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXjRpKWGJT85JKUdKWWF4y1IwifyHvWaSNcU17qJr9DCPDh84fGMen9FtlNU1LR9aO2HUm4wXlvnT/+4EE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdiiLndJ+ey0RtAqKGGutqt4PgmoXrMrP4+uedodA+Usx0iGZ3
	yRNydWT+bzGt4Ct0B2lJydVx7lSa3ZBffiYllcgR2LYKakTnvqb7+3yLTkH2jaVmFjrlMzMY8Jr
	VA8M6rgu563bbpqQTIPYsVxquBv8=
X-Google-Smtp-Source: AGHT+IHhzpspj1DIOZ4PtZvOzVipHy2O/HZsMdOTXW7mjXDy8Az68ueCYgoUk2zddJ6f4+KzdLuBg27U3wAbr6+Vo98=
X-Received: by 2002:a05:6808:11c3:b0:3e9:2090:c030 with SMTP id
 5614622812f47-3f39237974amr5672932b6e.25.1739109890073; Sun, 09 Feb 2025
 06:04:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 9 Feb 2025 15:04:36 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ggiSiuop5WeC5AZOHC_P_etyiOOW-EZstc3_i_8dEz3w@mail.gmail.com>
X-Gm-Features: AWEUYZlVQjHS2XyUFMFmMn-Nt5kqfM9Ea7ouVW1Ng-snpmYgA1_M_B5EpL1mi3w
Message-ID: <CAJZ5v0ggiSiuop5WeC5AZOHC_P_etyiOOW-EZstc3_i_8dEz3w@mail.gmail.com>
Subject: [GIT PULL] Additional power management fix for v6.14-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.14-rc2-2

with top-most commit 7585946243d614bd2cd4e13377be2c711c9539e0

 PM: sleep: core: Restrict power.set_active propagation

on top of commit 73195bed7899150cd1005cf0a902b68793adad23

 Merge branch 'pm-powercap'

to receive an additional power management fix for 6.14-rc2.

This fixes a recently introduced kernel crash due to a NULL pointer
dereference during system-wide suspend (Rafael Wysocki).

It is not present in linux-next, which is an exception as far as I am
concerned, but since the fix is effectively a partial revert and it has
been tested, I've decided to fast-track it so it gets into 6.14-rc2, if
possible.

Thanks!


---------------

Rafael J. Wysocki (1):
      PM: sleep: core: Restrict power.set_active propagation

---------------

 drivers/base/power/main.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

