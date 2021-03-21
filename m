Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E404343345
	for <lists+linux-pm@lfdr.de>; Sun, 21 Mar 2021 16:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhCUPsL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 21 Mar 2021 11:48:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:59448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229933AbhCUPsL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 21 Mar 2021 11:48:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 53C066194A
        for <linux-pm@vger.kernel.org>; Sun, 21 Mar 2021 15:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616341685;
        bh=/CCznOdLt4y8q3Ll5AxGg4Ms7P+YS5bp+RrizqiG7Oo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=EzRdbj1vY1DCAnVraCAqlz813Mde8MDH9f/F/0T0h37zp/XQPp1YeXW6JtwTS1lBW
         lvzBvilgEvB+jvaeLW14+Tgt9ThJDXB2RFYgL+Uk2oe99M5SFR/1UoiENNBRnXfmVz
         zm87e/z1kSbFejfei3+C3SOSWck8VpXQfCpdd2Kzw2i6dRqnEssLoJVeijIPrMutnT
         RDGT6E+BT+4oW4byr8BsGQinN1LREpKIFzYnAnRQ82Gb0YiqkgzFYRTZy4vWOLqRTg
         NzCnXZeP58fYBG0n8NsRZznJLfI/fAOoXAVH+yz81JO2F0YJEzMTvOQf1L2inKzbPB
         acu7QUXiAjz9w==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 4D22562AAF; Sun, 21 Mar 2021 15:48:05 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 209069] CPU stuck at 800 MHz at any load
Date:   Sun, 21 Mar 2021 15:48:04 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: dsmythies@telus.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-209069-137361-cQXOvomi5s@https.bugzilla.kernel.org/>
In-Reply-To: <bug-209069-137361@https.bugzilla.kernel.org/>
References: <bug-209069-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D209069

--- Comment #16 from Doug Smythies (dsmythies@telus.net) ---
Hi Rui,

Actually, e-mails about this bug report are on list, because it hasn't been
assigned.

I my opinion, this one can be closed because

CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE=3Dy

doesn't have a consistent meaning.
(And I argued this very point with Dirk Brandewie, the original author and
maintainer of the intel_pstate CPU frequency scaling driver, around 2013)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
