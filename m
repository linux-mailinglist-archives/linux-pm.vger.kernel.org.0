Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5400D1703D
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2019 06:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbfEHE7X (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 May 2019 00:59:23 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45420 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfEHE7X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 May 2019 00:59:23 -0400
Received: by mail-pf1-f196.google.com with SMTP id e24so9827559pfi.12;
        Tue, 07 May 2019 21:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=uv+cr3UWPmACRlIEgtiQra2smdl7Sym7R7Qit7K6ZOI=;
        b=vR7G+WW+PTmaYxKx2JGjnx+TO/SASNtV+ssRlB3l+F0QMJKpix/+cpLJSDrcrxR/c9
         KF3teCnDJJY2t32VOLE2a0gF6hKfj51wdBPOuTugo7saOm+pob3TNc2DFtPPT3fh1FeI
         87pA0u2rHIHslKyY5k1KWIzKj2oFLfTY0OH54DMXRbpKMb9VVQg+SXlHWCcWtkrh3qXg
         /Nr61iswM325GRSgC7naQPeyLgEYm9L6EcVztp/tfhPrkuWn6IwCUGI/WKmg7xOZo+Ov
         etQETSpFqQFV+5zYDv+CSkndRcXRCF4gjE4aWXKvchEY9yjwh+QWhKQ6Ik6xiagxeO03
         J6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=uv+cr3UWPmACRlIEgtiQra2smdl7Sym7R7Qit7K6ZOI=;
        b=Z3z7TlbXXvYX4AK579zghrBGv1xiIdEU6/Mtz/i2bJ12qbds5h9J6KvChppS+Gl8ke
         Z+3jy7wDeKJzIM0PI2m1VW+2cv1Fn77yhIjGst/95GHMuDyE4juKF5dYD831eMa1oolA
         aZefXUhbkeG8zsSRFmjdLmyuFrz9bWSLWyam+UcehOrgw9Vq0sUyh1gHTYtshZ40dB/3
         ICP+YNE7w3RjfX3rkR6l4IVRTS9pxJtbBof7tYvHjeyBgO9K78cBznBYUKLM6gi4Mwnq
         91w0txPI1OpONYP10bUfnRQOxF/b+G4Lh/HvNLJ5O/MpgBTBXcsi2UNIrGIfla66wLUL
         3ZXQ==
X-Gm-Message-State: APjAAAXzPuzFUB6Ic3yB+ofttULk/O2r9JRJexVJYcF7F3yb+PY2iY6o
        uAVWoZ5jbVX1OublTHsw5KY=
X-Google-Smtp-Source: APXvYqysggG6fawTukJyxPpFmm6P68sY/iFM72uVHKOky45vKDFnfbonXbQljCpqxIE/VfDS3QCX2w==
X-Received: by 2002:a62:4602:: with SMTP id t2mr46014067pfa.26.1557291562322;
        Tue, 07 May 2019 21:59:22 -0700 (PDT)
Received: from localhost ([203.63.161.72])
        by smtp.gmail.com with ESMTPSA id k67sm26046002pfb.44.2019.05.07.21.59.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 21:59:21 -0700 (PDT)
Date:   Wed, 08 May 2019 14:59:07 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 0/1] Forced-wakeup for stop lite states on Powernv
To:     Abhishek Goel <huntbag@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     daniel.lezcano@linaro.org, dja@axtens.net, ego@linux.vnet.ibm.com,
        rjw@rjwysocki.net
References: <20190422063231.51043-1-huntbag@linux.vnet.ibm.com>
In-Reply-To: <20190422063231.51043-1-huntbag@linux.vnet.ibm.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1557291178.ow4spjzq5t.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Abhishek Goel's on April 22, 2019 4:32 pm:
> Currently, the cpuidle governors determine what idle state a idling CPU
> should enter into based on heuristics that depend on the idle history on
> that CPU. Given that no predictive heuristic is perfect, there are cases
> where the governor predicts a shallow idle state, hoping that the CPU wil=
l
> be busy soon. However, if no new workload is scheduled on that CPU in the
> near future, the CPU will end up in the shallow state.
>=20
> Motivation
> ----------
> In case of POWER, this is problematic, when the predicted state in the
> aforementioned scenario is a lite stop state, as such lite states will
> inhibit SMT folding, thereby depriving the other threads in the core from
> using the core resources.
>=20
> So we do not want to get stucked in such states for longer duration. To
> address this, the cpuidle-core can queue timer to correspond with the
> residency value of the next available state. This timer will forcefully
> wakeup the cpu. Few such iterations will essentially train the governor t=
o
> select a deeper state for that cpu, as the timer here corresponds to the
> next available cpuidle state residency. Cpu will be kicked out of the lit=
e
> state and end up in a non-lite state.
>=20
> Experiment
> ----------
> I performed experiments for three scenarios to collect some data.
>=20
> case 1 :
> Without this patch and without tick retained, i.e. in a upstream kernel,
> It would spend more than even a second to get out of stop0_lite.
>=20
> case 2 : With tick retained in a upstream kernel -
>=20
> Generally, we have a sched tick at 4ms(CONF_HZ =3D 250). Ideally I expect=
ed
> it to take 8 sched tick to get out of stop0_lite. Experimentally,
> observation was
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> sample          min            max           99percentile
> 20              4ms            12ms          4ms
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> It would take atleast one sched tick to get out of stop0_lite.
>=20
> case 2 :  With this patch (not stopping tick, but explicitly queuing a
>           timer)
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> sample          min             max             99percentile
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 20              144us           192us           144us
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> In this patch, we queue a timer just before entering into a stop0_lite
> state. The timer fires at (residency of next available state + exit laten=
cy
> of next available state * 2). Let's say if next state(stop0) is available
> which has residency of 20us, it should get out in as low as (20+2*2)*8
> [Based on the forumla (residency + 2xlatency)*history length] microsecond=
s
> =3D 192us. Ideally we would expect 8 iterations, it was observed to get o=
ut
> in 6-7 iterations. Even if let's say stop2 is next available state(stop0
> and stop1 both are unavailable), it would take (100+2*10)*8 =3D 960us to =
get
> into stop2.
>=20
> So, We are able to get out of stop0_lite generally in 150us(with this
> patch) as compared to 4ms(with tick retained). As stated earlier, we do n=
ot
> want to get stuck into stop0_lite as it inhibits SMT folding for other
> sibling threads, depriving them of core resources. Current patch is using
> forced-wakeup only for stop0_lite, as it gives performance benefit(primar=
y
> reason) along with lowering down power consumption. We may extend this
> model for other states in future.

I still have to wonder, between our snooze loop and stop0, what does
stop0_lite buy us.

That said, the problem you're solving here is a generic one that all
stop states have, I think. Doesn't the same thing apply going from
stop0 to stop5? You might under estimate the sleep time and lose power
savings and therefore performance there too. Shouldn't we make it
generic for all stop states?

Thanks,
Nick

=
