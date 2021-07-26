Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E13BC3D5CCD
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jul 2021 17:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbhGZOhQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Jul 2021 10:37:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53616 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235010AbhGZOhP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Jul 2021 10:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627312663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FMlQ25hJH+R6pFD/1ahHb0bRBusBkFzxUiCW7bLMoRM=;
        b=FsXc7g6CCp7fRi/Zugz3/W+yI6mwq3ZP8nRX07GkLz3BvuXAap0UVDKisMrXbu0PnJFIv8
        h/WHgXBifEipww0BegoLl1N9z2HA1Dr8In0EX+ywCRmuGZLnSLxBTVDkfgxEw8kQciLiLi
        OM/QabP0QUPcaJw1EneqaETs9LON42A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-g6CjAF31OVu8ZPoQLsfTDA-1; Mon, 26 Jul 2021 11:17:42 -0400
X-MC-Unique: g6CjAF31OVu8ZPoQLsfTDA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94014107ACF5;
        Mon, 26 Jul 2021 15:17:40 +0000 (UTC)
Received: from localhost (ovpn-113-151.ams2.redhat.com [10.36.113.151])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 896FC19C59;
        Mon, 26 Jul 2021 15:17:39 +0000 (UTC)
Date:   Mon, 26 Jul 2021 16:17:38 +0100
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
Message-ID: <YP7SEkDEIBOch9U8@stefanha-x1.localdomain>
References: <20210713161906.457857-1-stefanha@redhat.com>
 <1008dee4-fce1-2462-1520-f5432bc89a07@redhat.com>
 <YPfryV7qZVRbjNgP@stefanha-x1.localdomain>
 <869a993d-a1b0-1c39-d081-4cdd2b71041f@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jE35KopBNKOzFkBR"
Content-Disposition: inline
In-Reply-To: <869a993d-a1b0-1c39-d081-4cdd2b71041f@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--jE35KopBNKOzFkBR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 22, 2021 at 05:04:57PM +0800, Jason Wang wrote:
>=20
> =E5=9C=A8 2021/7/21 =E4=B8=8B=E5=8D=885:41, Stefan Hajnoczi =E5=86=99=E9=
=81=93:
> > On Wed, Jul 21, 2021 at 11:29:55AM +0800, Jason Wang wrote:
> > > =E5=9C=A8 2021/7/14 =E4=B8=8A=E5=8D=8812:19, Stefan Hajnoczi =E5=86=
=99=E9=81=93:
> > > > These patches are not polished yet but I would like request feedbac=
k on this
> > > > approach and share performance results with you.
> > > >=20
> > > > Idle CPUs tentatively enter a busy wait loop before halting when th=
e cpuidle
> > > > haltpoll driver is enabled inside a virtual machine. This reduces w=
akeup
> > > > latency for events that occur soon after the vCPU becomes idle.
> > > >=20
> > > > This patch series extends the cpuidle busy wait loop with the new p=
oll_source
> > > > API so drivers can participate in polling. Such polling-aware drive=
rs disable
> > > > their device's irq during the busy wait loop to avoid the cost of i=
nterrupts.
> > > > This reduces latency further than regular cpuidle haltpoll, which s=
till relies
> > > > on irqs.
> > > >=20
> > > > Virtio drivers are modified to use the poll_source API so all virti=
o device
> > > > types get this feature. The following virtio-blk fio benchmark resu=
lts show the
> > > > improvement:
> > > >=20
> > > >                IOPS (numjobs=3D4, iodepth=3D1, 4 virtqueues)
> > > >                  before   poll_source      io_poll
> > > > 4k randread    167102  186049 (+11%)  186654 (+11%)
> > > > 4k randwrite   162204  181214 (+11%)  181850 (+12%)
> > > > 4k randrw      159520  177071 (+11%)  177928 (+11%)
> > > >=20
> > > > The comparison against io_poll shows that cpuidle poll_source achie=
ves
> > > > equivalent performance to the block layer's io_poll feature (which I
> > > > implemented in a separate patch series [1]).
> > > >=20
> > > > The advantage of poll_source is that applications do not need to ex=
plicitly set
> > > > the RWF_HIPRI I/O request flag. The poll_source approach is attract=
ive because
> > > > few applications actually use RWF_HIPRI and it takes advantage of C=
PU cycles we
> > > > would have spent in cpuidle haltpoll anyway.
> > > >=20
> > > > The current series does not improve virtio-net. I haven't investiga=
ted deeply,
> > > > but it is possible that NAPI and poll_source do not combine. See th=
e final
> > > > patch for a starting point on making the two work together.
> > > >=20
> > > > I have not tried this on bare metal but it might help there too. Th=
e cost of
> > > > disabling a device's irq must be less than the savings from avoidin=
g irq
> > > > handling for this optimization to make sense.
> > > >=20
> > > > [1] https://lore.kernel.org/linux-block/20210520141305.355961-1-ste=
fanha@redhat.com/
> > >=20
> > > Hi Stefan:
> > >=20
> > > Some questions:
> > >=20
> > > 1) What's the advantages of introducing polling at virtio level inste=
ad of
> > > doing it at each subsystems? Polling in virtio level may only work we=
ll if
> > > all (or most) of the devices are virtio
> > I'm not sure I understand the question. cpuidle haltpoll benefits all
> > devices today, except it incurs interrupt latency. The poll_source API
> > eliminates the interrupt latency for drivers that can disable device
> > interrupts cheaply.
> >=20
> > This patch adds poll_source to core virtio code so that all virtio
> > drivers get this feature for free. No driver-specific changes are
> > needed.
> >=20
> > If you mean networking, block layer, etc by "subsystems" then there's
> > nothing those subsystems can do to help. Whether poll_source can be used
> > depends on the specific driver, not the subsystem. If you consider
> > drivers/virtio/ a subsystem, then that's exactly what the patch series
> > is doing.
>=20
>=20
> I meant, if we choose to use idle poll, we have some several choices:
>=20
> 1) bus level (e.g the virtio)
> 2) subsystem level (e.g the networking and block)
>=20
> I'm not sure which one is better.

This API is intended to be driver- or bus-level. I don't think
subsystems can do very much since they don't know the hardware
capabilities (cheap interrupt disabling) and in most cases there's no
advantage of plumbing it through subsystems when drivers can call the
API directly.

> > > 2) What's the advantages of using cpuidle instead of using a thread (=
and
> > > leverage the scheduler)?
> > In order to combine with the existing cpuidle infrastructure. No new
> > polling loop is introduced and no additional CPU cycles are spent on
> > polling.
> >=20
> > If cpuidle itself is converted to threads then poll_source would
> > automatically operate in a thread too, but this patch series doesn't
> > change how the core cpuidle code works.
>=20
>=20
> So networking subsystem can use NAPI busy polling in the process context
> which means it can be leveraged by the scheduler.
>=20
> I'm not sure it's a good idea to poll drivers for a specific bus in the
> general cpu idle layer.

Why? Maybe because the cpuidle execution environment is a little special?

> Another questions, are those numbers measured by APICV capable machine?

Yes.

> Virtio-net turns on the tx interrupts since 2 years ago. And we don't see
> too much difference when measured with a APICV host.

My understand is NAPI always takes the first interrupt. Polling only
happens on subsequent rounds until there's no more work to do.

There seem to be multiple factors that would influence tx performance
like how full the tx queues are, whether more packets are sent during
NAPI polling, whether you're benchmarking a physical PCIe NIC or a
vhost_net software device, etc.

Regarding APICV and software devices, the benchmark results I posted
show that avoiding the interrupt injection helps even with APICV.

Stefan

--jE35KopBNKOzFkBR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmD+0hIACgkQnKSrs4Gr
c8hEMwf/UorkfbFzgbz8WztHfFLygTqvvZ+SQp1NtIS713IwgbLzCS1YSae8MgOx
1DbSdXqGM/iQUzorcrJVzKyc2jNsRAYDTw8bK0sF6XIAptbrDcHRFs/o6NAZw4vB
h4ohjd1H0UYaDgKZP0sX0ecu/V4gJ2IPteUcGS+L9ZfXw7IVSXFU/6iHAmkmSz6D
uwwBwvYgFKgmfeg1z0MGNHB2P8akYlGjHJkDX8oXQLVULAGqpCONfu347leIMM50
X1r9n8BUpJy9ieIKr1ED4uVmTJImbsR7ReXLFjp3U5DLErhWr8OEZL3wEA3q4J1M
7NAjTB9t4Aecd7549QNpbF16aC+pgQ==
=U0jQ
-----END PGP SIGNATURE-----

--jE35KopBNKOzFkBR--

