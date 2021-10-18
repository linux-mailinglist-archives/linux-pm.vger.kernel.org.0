Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625FA43113A
	for <lists+linux-pm@lfdr.de>; Mon, 18 Oct 2021 09:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhJRHQB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Oct 2021 03:16:01 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:48714 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbhJRHQB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Oct 2021 03:16:01 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 827521C0B76; Mon, 18 Oct 2021 09:13:49 +0200 (CEST)
Date:   Mon, 18 Oct 2021 09:13:49 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, rafael@kernel.org,
        len.brown@intel.com, linux-pm@vger.kernel.org,
        sfr@canb.auug.org.au, peterz@infradead.org, gor@linux.ibm.com
Subject: Re: next-20211015: suspend to ram on x86-32 broken
Message-ID: <20211018071349.GA16631@duo.ucw.cz>
References: <20211017093905.GA3069@amd>
 <20211017102547.GA3818@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <20211017102547.GA3818@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> On Thinkpad X60, suspend to ram no longer works. Suspend is okay, and
> there are some signs of resume attempts for second or so, but screen
> stays black and sleep LED stays on.

I did a bisection:

# bad: [7c832d2f9b959e3181370c8b0dacaf9efe13fc05] Add linux-next specific f=
iles for 20211015
# good: [64570fbc14f8d7cb3fe3995f20e26bc25ce4b2cc] Linux 5.15-rc5
git bisect start 'next-20211015' 'HEAD'
# good: [048c22e37f3dee5adf67e97c48735c325edbb178] Merge branch 'master' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
git bisect good 048c22e37f3dee5adf67e97c48735c325edbb178
# bad: [ff4d6dddf948544ef8fa7e5b539ced1f854c0a7f] Merge branch 'auto-latest=
' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
git bisect bad ff4d6dddf948544ef8fa7e5b539ced1f854c0a7f
# good: [3d4352bd49acf0f81a2dae28e910e80c80aec115] Merge branch 'drm-next' =
of https://gitlab.freedesktop.org/agd5f/linux
git bisect good 3d4352bd49acf0f81a2dae28e910e80c80aec115
# good: [5e135c8bb89c9f83e7db6216b2bff96c5433728c] Merge branch 'for-next' =
of git://git.kernel.dk/linux-block.git
git bisect good 5e135c8bb89c9f83e7db6216b2bff96c5433728c
# good: [6e85e7634927384c362395bda82e3759ae94c7c6] Merge branch 'for-next' =
of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
git bisect good 6e85e7634927384c362395bda82e3759ae94c7c6
# good: [ac716d0d92cbb48cd635a4ac41829f8ebd7f369c] Merge remote-tracking br=
anch 'tip/locking/core' into tip-master
git bisect good ac716d0d92cbb48cd635a4ac41829f8ebd7f369c
# bad: [a5dd661e53635877debbf48045913266b429950a] Merge remote-tracking bra=
nch 'tip/sched/core' into tip-master
git bisect bad a5dd661e53635877debbf48045913266b429950a
# good: [16d364ba6ef2aa59b409df70682770f3ed23f7c0] sched/topology: Introduc=
e sched_group::flags
git bisect good 16d364ba6ef2aa59b409df70682770f3ed23f7c0
# good: [769fdf83df57b373660343ef4270b3ada91ef434] sched: Fix DEBUG && !SCH=
EDSTATS warn
git bisect good 769fdf83df57b373660343ef4270b3ada91ef434
# bad: [b6153093de41186e2c534ffffb8ce81b1666b110] sched/numa: Replace hard-=
coded number by a define in numa_task_group()
git bisect bad b6153093de41186e2c534ffffb8ce81b1666b110
# good: [00619f7c650e4e46c650cb2e2fd5f438b32dc64b] sched,livepatch: Use tas=
k_call_func()
git bisect good 00619f7c650e4e46c650cb2e2fd5f438b32dc64b
# bad: [2aa45be430a031c10d5f4a5bf3329ff8413a9187] sched,livepatch: Use wake=
_up_if_idle()
git bisect bad 2aa45be430a031c10d5f4a5bf3329ff8413a9187

It said

commit 8850cb663b5cda04d33f9cfbc38889d73d3c8e24 (HEAD)
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Tue Sep 21 22:16:02 2021 +0200

    sched: Simplify wake_up_*idle*()

is first bad commit.

--=20
http://www.livejournal.com/~pavelmachek

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYW0erQAKCRAw5/Bqldv6
8j23AJ90gv1rPzZSPyOcDnrPUtjSAiPHyQCeKWYbwxF2/u6JBAwsrZIRLY/RzXc=
=RK32
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
