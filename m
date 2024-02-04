Return-Path: <linux-pm+bounces-3347-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9458848E44
	for <lists+linux-pm@lfdr.de>; Sun,  4 Feb 2024 15:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7120728317E
	for <lists+linux-pm@lfdr.de>; Sun,  4 Feb 2024 14:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FA8224D2;
	Sun,  4 Feb 2024 14:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2VGMZCh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53811E51A
	for <linux-pm@vger.kernel.org>; Sun,  4 Feb 2024 14:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707055700; cv=none; b=ASK/ULDiZVF2yY9V3imoK2TDp5qT+pFaKgDOjuJTAzdxtXyu6k1XCldSRJ6w/H4lsZS2yimOBT8BX1ucKLG/eDND1pZn8DaTnCOakUw61+Z4KS6w2NMsszv8Lxn5wLGOB9pZ2wKGNUxvZumtlVDTVk+eNOFsHZwhbNU6vS851oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707055700; c=relaxed/simple;
	bh=q/qTpjBes+0TQPVSC6e1ywOTnmZW6h14fSLxOiqR6oo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UJhu/OVAnplSSAQCFtxT8wX8TJFazhy+8ML1QAOmy5TkeTJ9/x8rQFrUF3eM73mEUsteU9fMieR0nNKLVnuHtlBISsjig+OGOjteegK439qqwbOzKUTbdNeNfD26CgGymbDIL89Tn7NB4h7+yzLW9JufP/75MupkhTaah4BC/rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2VGMZCh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34396C43394
	for <linux-pm@vger.kernel.org>; Sun,  4 Feb 2024 14:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707055700;
	bh=q/qTpjBes+0TQPVSC6e1ywOTnmZW6h14fSLxOiqR6oo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=E2VGMZChTLT2GZqf4SYlgnk+Ifbzq+RLKWiQXD5OIi2gBeHUTgPQ9s1c8upQmV6wg
	 nBt7bgw99MdW5gP2fwKXR0jxrAmhukXBqdGS5GHUobOCgt3o8q7D5LhZId1HGGHzl5
	 YVTV7iDRkmYDGiFcAak9LbZiKAYteNtwBRTDnOqe2X+qHib3noiNdBalbu2yrX1RmK
	 6bZq5dVxM7k/86xzdFoi3GVAqwynhfCZmnNHNsuWQJ0DPcsJwHEP5OP/qqpJUzscJo
	 m4/x+blmlizCkikXnMm4Ug5J9J+vnZLo9uPe6j1n+K1B6EqU5YrHRqpUAzBiywynXN
	 WsHNkkRPpJHFg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2012CC53BD5; Sun,  4 Feb 2024 14:08:20 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218171] amd-pstate not loading on zen2 threadripper 3960x
 (trx40
Date: Sun, 04 Feb 2024 14:08:19 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: gilvbp@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218171-137361-W8yRxJIzxJ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218171-137361@https.bugzilla.kernel.org/>
References: <bug-218171-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D218171

Gil Vicente B. (gilvbp@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |gilvbp@gmail.com

--- Comment #44 from Gil Vicente B. (gilvbp@gmail.com) ---

For all of you, Thank you very much!

Awesome work!=20

All good on:

kernel: 6.7.3-zen1-2-zen
ROG ZENITH II EXTREME (v1802)
AMD Ryzen Threadripper 3970X=20

driver: amd-pstate-epp
  CPUs que rodam na mesma frequ=C3=AAncia de hardware: 63
  CPUs que precisam ter suas frequ=C3=AAncias coordenadas por software: 63
  maior lat=C3=AAncia de transi=C3=A7=C3=A3o:  Cannot determine or is not s=
upported.
  limites do hardware: 550 MHz - 4.65 GHz
  reguladores do cpufreq dispon=C3=ADveis: performance powersave
  pol=C3=ADtica de frequ=C3=AAncia atual deve estar entre 3.70 GHz e 4.50 G=
Hz.
                  O regulador "performance" deve decidir qual velocidade us=
ar
                  dentro desse limite.
  current CPU frequency: Unable to call hardware
  current CPU frequency: 4.22 GHz (asserted by call to kernel)
  boost state support:
    Supported: yes
    Active: yes
    AMD PSTATE Highest Performance: 166. Maximum Frequency: 4.65 GHz.
    AMD PSTATE Nominal Performance: 132. Nominal Frequency: 3.70 GHz.
    AMD PSTATE Lowest Non-linear Performance: 62. Lowest Non-linear Frequen=
cy:
1.73 GHz.
    AMD PSTATE Lowest Performance: 20. Lowest Frequency: 550 MHz.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

