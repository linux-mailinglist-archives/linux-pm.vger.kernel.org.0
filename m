Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00C1A365604
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 12:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbhDTKVN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Apr 2021 06:21:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:49582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230264AbhDTKVM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 20 Apr 2021 06:21:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 875DC613C3
        for <linux-pm@vger.kernel.org>; Tue, 20 Apr 2021 10:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618914041;
        bh=NV1/HtvOQPesYVSAzC+vI67wkYj+MFf/lfKQgqenKCE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=baIrXaqZAnvjQuhLwnKNfQIwI0kOjhsMjZSWNb75/pG8O6AWNBoyYiqz1IbdYJ736
         upayzSw1+oiVmv365DTRQjZl3jblpxcGgCrhY/d6mLIHQ7/3UXOK47L94l9XzR54SN
         F3yWPKIvknRUYpGh1ZV9CUuHTrvOzHkk18xl119KEmOVjUOu1hLLdQWGkNb4efzzIv
         DyWZ2BdY1rHmm9pxmeUstlEX6PqETL5i+W0Fe+mGplihXu/z5WOQsWxT7OiXdAveHX
         XJFQPh5/64eyTLW08Zl9+0S6pMgw/eeH19RkeFwd8X6aHVxq3avVmt5H+AWogB7n8Q
         M+LyoKybVDp5g==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 7DA82611BE; Tue, 20 Apr 2021 10:20:41 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 211791] AMD CPU /proc/cpuinfo reported max potential boost
 frequency instead of actual operating frequency
Date:   Tue, 20 Apr 2021 10:20:41 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: ray.huang@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-211791-137361-zPYOQSoCjA@https.bugzilla.kernel.org/>
In-Reply-To: <bug-211791-137361@https.bugzilla.kernel.org/>
References: <bug-211791-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D211791

--- Comment #4 from Huang Rui (ray.huang@amd.com) ---
Hi all,

This patch should fix the issue:

https://lore.kernel.org/r/20210420080943.1045886-1-ray.huang@amd.com

Thanks,
Ray

On Tue, Apr 20, 2021 at 08:55:00AM +0000, bugzilla-daemon@bugzilla.kernel.o=
rg
wrote:
>
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbugzi=
lla.kernel.org%2Fshow_bug.cgi%3Fid%3D211791&amp;data=3D04%7C01%7Cray.huang%=
40amd.com%7Cc3e664b79fec434b1a2208d903d9fc2c%7C3dd8961fe4884e608e11a82d994e=
183d%7C0%7C0%7C637545057044777992%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwM=
DAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DeoZS70=
ZYQ7Rvh7XUNBL%2FPi4pxALBsbOyic6QnhOL2Xg%3D&amp;reserved=3D0
>=20
> Eugenia Campos (rizwanali.462371@gmail.com) changed:
>=20
>            What    |Removed                     |Added
> -------------------------------------------------------------------------=
---
>                  CC|                            |rizwanali.462371@gmail.c=
om
>=20
> --- Comment #3 from Eugenia Campos (rizwanali.462371@gmail.com) ---
> Maxilla and all joyful end is placed for the founding items for the citiz=
ens.
> The show of the jump and
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.e=
ssaygeeks.co.uk%2Fwrite-my-essay%2F&amp;data=3D04%7C01%7Cray.huang%40amd.co=
m%7Cc3e664b79fec434b1a2208d903d9fc2c%7C3dd8961fe4884e608e11a82d994e183d%7C0=
%7C0%7C637545057044777992%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQI=
joiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DNOvSMR08NNdIOi=
k9fqcy2PE4IP8LDYQOB4SZfjx3Nlo%3D&amp;reserved=3D0
> is
> shifted for the takes. The mode is pushed for the hope of the shows for
> humans.
>=20
> --=20
> You may reply to this email to add a comment.
>=20
> You are receiving this mail because:
> You are the assignee for the bug.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
