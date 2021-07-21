Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B923D0C35
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jul 2021 12:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237444AbhGUJU1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Jul 2021 05:20:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60226 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236733AbhGUJBH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Jul 2021 05:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626860503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TDBluuFB4Emt7468WeyjkHVbK6/rC03Tb1lfcuLDBLU=;
        b=eCHM8pI+OZtc84DvLBB6pAI6XoYrcV1M/F3HSRDFBSe2Od4loJDG/g8SmkoaxRyNXmeN1d
        jXLQ+0ugy1HKVQ4GaNcoq+kPY1Q4LyBt6H+PEAqp4tg6w5RmnMD5SB5ag79bR1irXsLdJU
        SBtwkAimQ/SUVcwB5QOltKQAvFtLhLU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-5kiFAxWbPDm2L0-Gll-sLw-1; Wed, 21 Jul 2021 05:41:40 -0400
X-MC-Unique: 5kiFAxWbPDm2L0-Gll-sLw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DF4C8B94E3;
        Wed, 21 Jul 2021 09:41:38 +0000 (UTC)
Received: from localhost (ovpn-114-233.ams2.redhat.com [10.36.114.233])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1292160E1C;
        Wed, 21 Jul 2021 09:41:30 +0000 (UTC)
Date:   Wed, 21 Jul 2021 10:41:29 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Ming Lei <ming.lei@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        virtualization@lists.linux-foundation.org,
        linux-pm@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC 0/3] cpuidle: add poll_source API and virtio vq polling
Message-ID: <YPfryV7qZVRbjNgP@stefanha-x1.localdomain>
References: <20210713161906.457857-1-stefanha@redhat.com>
 <1008dee4-fce1-2462-1520-f5432bc89a07@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="U3hY+f6lEQj1AEW4"
Content-Disposition: inline
In-Reply-To: <1008dee4-fce1-2462-1520-f5432bc89a07@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--U3hY+f6lEQj1AEW4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 21, 2021 at 11:29:55AM +0800, Jason Wang wrote:
>=20
> =E5=9C=A8 2021/7/14 =E4=B8=8A=E5=8D=8812:19, Stefan Hajnoczi =E5=86=99=E9=
=81=93:
> > These patches are not polished yet but I would like request feedback on=
 this
> > approach and share performance results with you.
> >=20
> > Idle CPUs tentatively enter a busy wait loop before halting when the cp=
uidle
> > haltpoll driver is enabled inside a virtual machine. This reduces wakeup
> > latency for events that occur soon after the vCPU becomes idle.
> >=20
> > This patch series extends the cpuidle busy wait loop with the new poll_=
source
> > API so drivers can participate in polling. Such polling-aware drivers d=
isable
> > their device's irq during the busy wait loop to avoid the cost of inter=
rupts.
> > This reduces latency further than regular cpuidle haltpoll, which still=
 relies
> > on irqs.
> >=20
> > Virtio drivers are modified to use the poll_source API so all virtio de=
vice
> > types get this feature. The following virtio-blk fio benchmark results =
show the
> > improvement:
> >=20
> >               IOPS (numjobs=3D4, iodepth=3D1, 4 virtqueues)
> >                 before   poll_source      io_poll
> > 4k randread    167102  186049 (+11%)  186654 (+11%)
> > 4k randwrite   162204  181214 (+11%)  181850 (+12%)
> > 4k randrw      159520  177071 (+11%)  177928 (+11%)
> >=20
> > The comparison against io_poll shows that cpuidle poll_source achieves
> > equivalent performance to the block layer's io_poll feature (which I
> > implemented in a separate patch series [1]).
> >=20
> > The advantage of poll_source is that applications do not need to explic=
itly set
> > the RWF_HIPRI I/O request flag. The poll_source approach is attractive =
because
> > few applications actually use RWF_HIPRI and it takes advantage of CPU c=
ycles we
> > would have spent in cpuidle haltpoll anyway.
> >=20
> > The current series does not improve virtio-net. I haven't investigated =
deeply,
> > but it is possible that NAPI and poll_source do not combine. See the fi=
nal
> > patch for a starting point on making the two work together.
> >=20
> > I have not tried this on bare metal but it might help there too. The co=
st of
> > disabling a device's irq must be less than the savings from avoiding irq
> > handling for this optimization to make sense.
> >=20
> > [1] https://lore.kernel.org/linux-block/20210520141305.355961-1-stefanh=
a@redhat.com/
>=20
>=20
> Hi Stefan:
>=20
> Some questions:
>=20
> 1) What's the advantages of introducing polling at virtio level instead of
> doing it at each subsystems? Polling in virtio level may only work well if
> all (or most) of the devices are virtio

I'm not sure I understand the question. cpuidle haltpoll benefits all
devices today, except it incurs interrupt latency. The poll_source API
eliminates the interrupt latency for drivers that can disable device
interrupts cheaply.

This patch adds poll_source to core virtio code so that all virtio
drivers get this feature for free. No driver-specific changes are
needed.

If you mean networking, block layer, etc by "subsystems" then there's
nothing those subsystems can do to help. Whether poll_source can be used
depends on the specific driver, not the subsystem. If you consider
drivers/virtio/ a subsystem, then that's exactly what the patch series
is doing.

> 2) What's the advantages of using cpuidle instead of using a thread (and
> leverage the scheduler)?

In order to combine with the existing cpuidle infrastructure. No new
polling loop is introduced and no additional CPU cycles are spent on
polling.

If cpuidle itself is converted to threads then poll_source would
automatically operate in a thread too, but this patch series doesn't
change how the core cpuidle code works.

> 3) Any reason it's virtio_pci specific not a general virtio one?

Good idea, it is possible to move the virtio_pci changes into virtio.c.

Other transports can't use this feature yet though. Only virtio_pci
supports vq irq affinity. But the code can be generic and if other
transports ever support vq irq affinity they'll get it for free.

> (Btw, do we need to cc scheduler guys?)

I'm not sure. This patch series doesn't change how cpuidle interacts
with the scheduler. The cpuidle maintainers can pull in more people, if
necessary.

Stefan

--U3hY+f6lEQj1AEW4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmD368kACgkQnKSrs4Gr
c8i8JAf9HH8W0fz2vJuNPKVE0C0NjgfddSwNS/qOC8QlvWYGeNomDImzTeWf04Dg
F4QU7Mx2cI2kUyxo8bRCPwLp6bsRw6PZyztQSN/GAJw3Y6sGdLhgizW4GKjGwHWs
0a5UDJ7JQUlg/4d9NNEAf6MhN3jZnvJBUpYXzsbIgEPRkiaJzZG1TpEZa3yxd8qc
4AWL97LrIbUPV20oZULnlYtaQbEICaG/VO+ORH/3vjioqAXTr7uALXq7w66hMG6I
gtgH5iq3V/10HSTzAhIiQHizUMQ1b2pdX9Vz4x/+KTcYsgsud2V+TCAJeBKo32bO
JVo0XAVh6Cl0oUt4xdworkCl46gbrg==
=U9/g
-----END PGP SIGNATURE-----

--U3hY+f6lEQj1AEW4--

