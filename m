Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D743D76D2
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jul 2021 15:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbhG0NdH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Jul 2021 09:33:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47631 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236537AbhG0NdH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jul 2021 09:33:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627392787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fm8lgs96oZg9fEfhAHy4eXddFvZa4+bpbiafqpalwmA=;
        b=SXDHpDdTzjwkClz57ZH21Z9Z/5Gi+yb1Y8C8Q5Vvh8HdVZJyTRSKUyNy//76rAhIZvWRd8
        iaS8WJ+wSbtZiRHQOY1t3xcgVgQJiAlb9MTQsTfzPnchfHGfQUFB1SkZWa10Qgu7qztBlj
        EQvIEnW32ND8rTh98sWGaCuNCk7N8Es=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-PY1Mr8BuOeCKUF6RQkf9dQ-1; Tue, 27 Jul 2021 09:33:03 -0400
X-MC-Unique: PY1Mr8BuOeCKUF6RQkf9dQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 128CA801AE7;
        Tue, 27 Jul 2021 13:33:02 +0000 (UTC)
Received: from localhost (ovpn-113-165.ams2.redhat.com [10.36.113.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 930F61970F;
        Tue, 27 Jul 2021 13:32:52 +0000 (UTC)
Date:   Tue, 27 Jul 2021 14:32:51 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Jason Wang <jasowang@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Ming Lei <ming.lei@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        virtualization@lists.linux-foundation.org,
        Linux PM <linux-pm@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC 0/3] cpuidle: add poll_source API and virtio vq polling
Message-ID: <YQALA8sQMx0xYtt+@stefanha-x1.localdomain>
References: <20210713161906.457857-1-stefanha@redhat.com>
 <1008dee4-fce1-2462-1520-f5432bc89a07@redhat.com>
 <YPfryV7qZVRbjNgP@stefanha-x1.localdomain>
 <869a993d-a1b0-1c39-d081-4cdd2b71041f@redhat.com>
 <YP7SEkDEIBOch9U8@stefanha-x1.localdomain>
 <CAJZ5v0h+RrRP-3MtV8dgxmba0rDfqoOw54DsFh0yx3YGUAVRqw@mail.gmail.com>
 <YP7cTjrfipfsJe9O@stefanha-x1.localdomain>
 <CAJZ5v0i4+2xda4Z6=JwRQf4ZzM2_agiyCwhMDRzAC-yz39fGzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="N2H8x3xJ2augdtSN"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i4+2xda4Z6=JwRQf4ZzM2_agiyCwhMDRzAC-yz39fGzg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--N2H8x3xJ2augdtSN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 26, 2021 at 06:37:13PM +0200, Rafael J. Wysocki wrote:
> On Mon, Jul 26, 2021 at 6:04 PM Stefan Hajnoczi <stefanha@redhat.com> wro=
te:
> >
> > On Mon, Jul 26, 2021 at 05:47:19PM +0200, Rafael J. Wysocki wrote:
> > > On Mon, Jul 26, 2021 at 5:17 PM Stefan Hajnoczi <stefanha@redhat.com>=
 wrote:
> > > >
> > > > On Thu, Jul 22, 2021 at 05:04:57PM +0800, Jason Wang wrote:
> > > > >
> > > > > =E5=9C=A8 2021/7/21 =E4=B8=8B=E5=8D=885:41, Stefan Hajnoczi =E5=
=86=99=E9=81=93:
> > > > > > On Wed, Jul 21, 2021 at 11:29:55AM +0800, Jason Wang wrote:
> > > > > > > =E5=9C=A8 2021/7/14 =E4=B8=8A=E5=8D=8812:19, Stefan Hajnoczi =
=E5=86=99=E9=81=93:
> > > > > > > > These patches are not polished yet but I would like request=
 feedback on this
> > > > > > > > approach and share performance results with you.
> > > > > > > >
> > > > > > > > Idle CPUs tentatively enter a busy wait loop before halting=
 when the cpuidle
> > > > > > > > haltpoll driver is enabled inside a virtual machine. This r=
educes wakeup
> > > > > > > > latency for events that occur soon after the vCPU becomes i=
dle.
> > > > > > > >
> > > > > > > > This patch series extends the cpuidle busy wait loop with t=
he new poll_source
> > > > > > > > API so drivers can participate in polling. Such polling-awa=
re drivers disable
> > > > > > > > their device's irq during the busy wait loop to avoid the c=
ost of interrupts.
> > > > > > > > This reduces latency further than regular cpuidle haltpoll,=
 which still relies
> > > > > > > > on irqs.
> > > > > > > >
> > > > > > > > Virtio drivers are modified to use the poll_source API so a=
ll virtio device
> > > > > > > > types get this feature. The following virtio-blk fio benchm=
ark results show the
> > > > > > > > improvement:
> > > > > > > >
> > > > > > > >                IOPS (numjobs=3D4, iodepth=3D1, 4 virtqueues)
> > > > > > > >                  before   poll_source      io_poll
> > > > > > > > 4k randread    167102  186049 (+11%)  186654 (+11%)
> > > > > > > > 4k randwrite   162204  181214 (+11%)  181850 (+12%)
> > > > > > > > 4k randrw      159520  177071 (+11%)  177928 (+11%)
> > > > > > > >
> > > > > > > > The comparison against io_poll shows that cpuidle poll_sour=
ce achieves
> > > > > > > > equivalent performance to the block layer's io_poll feature=
 (which I
> > > > > > > > implemented in a separate patch series [1]).
> > > > > > > >
> > > > > > > > The advantage of poll_source is that applications do not ne=
ed to explicitly set
> > > > > > > > the RWF_HIPRI I/O request flag. The poll_source approach is=
 attractive because
> > > > > > > > few applications actually use RWF_HIPRI and it takes advant=
age of CPU cycles we
> > > > > > > > would have spent in cpuidle haltpoll anyway.
> > > > > > > >
> > > > > > > > The current series does not improve virtio-net. I haven't i=
nvestigated deeply,
> > > > > > > > but it is possible that NAPI and poll_source do not combine=
=2E See the final
> > > > > > > > patch for a starting point on making the two work together.
> > > > > > > >
> > > > > > > > I have not tried this on bare metal but it might help there=
 too. The cost of
> > > > > > > > disabling a device's irq must be less than the savings from=
 avoiding irq
> > > > > > > > handling for this optimization to make sense.
> > > > > > > >
> > > > > > > > [1] https://lore.kernel.org/linux-block/20210520141305.3559=
61-1-stefanha@redhat.com/
> > > > > > >
> > > > > > > Hi Stefan:
> > > > > > >
> > > > > > > Some questions:
> > > > > > >
> > > > > > > 1) What's the advantages of introducing polling at virtio lev=
el instead of
> > > > > > > doing it at each subsystems? Polling in virtio level may only=
 work well if
> > > > > > > all (or most) of the devices are virtio
> > > > > > I'm not sure I understand the question. cpuidle haltpoll benefi=
ts all
> > > > > > devices today, except it incurs interrupt latency. The poll_sou=
rce API
> > > > > > eliminates the interrupt latency for drivers that can disable d=
evice
> > > > > > interrupts cheaply.
> > > > > >
> > > > > > This patch adds poll_source to core virtio code so that all vir=
tio
> > > > > > drivers get this feature for free. No driver-specific changes a=
re
> > > > > > needed.
> > > > > >
> > > > > > If you mean networking, block layer, etc by "subsystems" then t=
here's
> > > > > > nothing those subsystems can do to help. Whether poll_source ca=
n be used
> > > > > > depends on the specific driver, not the subsystem. If you consi=
der
> > > > > > drivers/virtio/ a subsystem, then that's exactly what the patch=
 series
> > > > > > is doing.
> > > > >
> > > > >
> > > > > I meant, if we choose to use idle poll, we have some several choi=
ces:
> > > > >
> > > > > 1) bus level (e.g the virtio)
> > > > > 2) subsystem level (e.g the networking and block)
> > > > >
> > > > > I'm not sure which one is better.
> > > >
> > > > This API is intended to be driver- or bus-level. I don't think
> > > > subsystems can do very much since they don't know the hardware
> > > > capabilities (cheap interrupt disabling) and in most cases there's =
no
> > > > advantage of plumbing it through subsystems when drivers can call t=
he
> > > > API directly.
> > > >
> > > > > > > 2) What's the advantages of using cpuidle instead of using a =
thread (and
> > > > > > > leverage the scheduler)?
> > > > > > In order to combine with the existing cpuidle infrastructure. N=
o new
> > > > > > polling loop is introduced and no additional CPU cycles are spe=
nt on
> > > > > > polling.
> > > > > >
> > > > > > If cpuidle itself is converted to threads then poll_source would
> > > > > > automatically operate in a thread too, but this patch series do=
esn't
> > > > > > change how the core cpuidle code works.
> > > > >
> > > > >
> > > > > So networking subsystem can use NAPI busy polling in the process =
context
> > > > > which means it can be leveraged by the scheduler.
> > > > >
> > > > > I'm not sure it's a good idea to poll drivers for a specific bus =
in the
> > > > > general cpu idle layer.
> > > >
> > > > Why? Maybe because the cpuidle execution environment is a little sp=
ecial?
> > >
> > > Well, this would be prone to abuse.
> > >
> > > The time spent in that driver callback counts as CPU idle time while
> > > it really is the driver running and there is not limit on how much
> > > time the callback can take, while doing costly things in the idle loop
> > > is generally avoided, because on wakeup the CPU needs to be available
> > > to the task needing it as soon as possible.  IOW, the callback
> > > potentially add unbounded latency to the CPU wakeup path.
> >
> > How is this different from driver interrupt handlers running during
> > cpuidle?
>=20
> The time spent on handling interrupts does not count as CPU idle time.

Is that taken care of by account_hardirq_enter()?

Drivers using poll_source have two pieces:
1. A small piece of code that polls the device.
2. A larger piece of code that runs when polling succeeds. This is
   basically the irq handler.

Would it be acceptable to run #1 from cpuidle but defer #2 so it's not
accounted as idle time?

Thanks,
Stefan

--N2H8x3xJ2augdtSN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmEACwMACgkQnKSrs4Gr
c8gr+gf+Krz5uK7igE9flabFjcMXVxdI4o6fMwLG0LUmsULn4HOQiWMd2CU/UpUe
RurunecxzjmCJyTQim82onIX81MZJMeVK2GJCcuTOu+Ggbr+tbhXO3lsSBWPDpbT
7MgNxG+y4Unv2ErSZLS+OWPq6gYLXgBpecOBthE1yJux2K/s1CcAPeF7QEdoTZut
HKKqrdVVH51c+tn8LG9Xgviza8Gpvr5tgovCGyTN15f9d36FNgW0Xq7/hKVjk1yx
hY3U+dTkfSWvsYJS3K/KKrjIppWt0rr+71tjNC+l4ngTLb9npGmNWJ0B02cac6Yd
j/REXsTsnGf7Dw7brj2Mhdr99yDf/A==
=Gpcr
-----END PGP SIGNATURE-----

--N2H8x3xJ2augdtSN--

