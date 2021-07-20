Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D21D3CFBDD
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jul 2021 16:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239667AbhGTNhH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Jul 2021 09:37:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29839 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239631AbhGTNeo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Jul 2021 09:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626790521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yVh614k8XczoxAnivfOALj8T/GknWKQDl21Rewvqr1U=;
        b=H/Bhx3pz31dERw8HSP46wAGXpFahDyBXOZZOHLPlh6Oj0ZrSEJDQnVdaOePZynCPMMoq9Q
        Kb451U4TXwqh/KDVWr4YNvXJtEl6r4IQ3oCThsqsGvK/ZUIZKQGhxXBxFkSTU7a2L/M7uz
        d2Rj2oeVpNQME5ulmUXY+R3y6qYSteg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-FdvdGIkSOXSxuJ0fIZAfjA-1; Tue, 20 Jul 2021 10:15:19 -0400
X-MC-Unique: FdvdGIkSOXSxuJ0fIZAfjA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C716A8030B5;
        Tue, 20 Jul 2021 14:15:17 +0000 (UTC)
Received: from localhost (ovpn-114-103.ams2.redhat.com [10.36.114.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 294285D6A1;
        Tue, 20 Jul 2021 14:15:17 +0000 (UTC)
Date:   Tue, 20 Jul 2021 15:15:16 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Ming Lei <ming.lei@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Jason Wang <jasowang@redhat.com>,
        linux-block@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        virtualization@lists.linux-foundation.org,
        linux-pm@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC 1/3] cpuidle: add poll_source API
Message-ID: <YPbadGW2DP0Bd67P@stefanha-x1.localdomain>
References: <20210713161906.457857-1-stefanha@redhat.com>
 <20210713161906.457857-2-stefanha@redhat.com>
 <20210719210355.GA46373@fuller.cnet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="b+tZ28pnN4/86HI2"
Content-Disposition: inline
In-Reply-To: <20210719210355.GA46373@fuller.cnet>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--b+tZ28pnN4/86HI2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 19, 2021 at 06:03:55PM -0300, Marcelo Tosatti wrote:
> Hi Stefan,
>=20
> On Tue, Jul 13, 2021 at 05:19:04PM +0100, Stefan Hajnoczi wrote:
> > Introduce an API for adding cpuidle poll callbacks:
> >=20
> >   struct poll_source_ops {
> >       void (*start)(struct poll_source *src);
> >       void (*stop)(struct poll_source *src);
> >       void (*poll)(struct poll_source *src);
> >   };
> >=20
> >   int poll_source_register(struct poll_source *src);
> >   int poll_source_unregister(struct poll_source *src);
> >=20
> > When cpuidle enters the poll state it invokes ->start() and then invokes
> > ->poll() repeatedly from the busy wait loop. Finally ->stop() is invoked
> > when the busy wait loop finishes.
> >=20
> > The ->poll() function should check for activity and cause
> > TIF_NEED_RESCHED to be set in order to stop the busy wait loop.
> >=20
> > This API is intended to be used by drivers that can cheaply poll for
> > events. Participating in cpuidle polling allows them to avoid interrupt
> > latencies during periods where the CPU is going to poll anyway.
> >=20
> > Note that each poll_source is bound to a particular CPU. The API is
> > mainly intended to by used by drivers that have multiple queues with irq
> > affinity.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  drivers/cpuidle/Makefile      |  1 +
> >  include/linux/poll_source.h   | 53 +++++++++++++++++++
> >  drivers/cpuidle/poll_source.c | 99 +++++++++++++++++++++++++++++++++++
> >  drivers/cpuidle/poll_state.c  |  6 +++
> >  4 files changed, 159 insertions(+)
> >  create mode 100644 include/linux/poll_source.h
> >  create mode 100644 drivers/cpuidle/poll_source.c
> >=20
> > diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
> > index 26bbc5e74123..994f72d6fe95 100644
> > --- a/drivers/cpuidle/Makefile
> > +++ b/drivers/cpuidle/Makefile
> > @@ -7,6 +7,7 @@ obj-y +=3D cpuidle.o driver.o governor.o sysfs.o govern=
ors/
> >  obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) +=3D coupled.o
> >  obj-$(CONFIG_DT_IDLE_STATES)		  +=3D dt_idle_states.o
> >  obj-$(CONFIG_ARCH_HAS_CPU_RELAX)	  +=3D poll_state.o
> > +obj-$(CONFIG_ARCH_HAS_CPU_RELAX)	  +=3D poll_source.o
> >  obj-$(CONFIG_HALTPOLL_CPUIDLE)		  +=3D cpuidle-haltpoll.o
> > =20
> >  ######################################################################=
############
> > diff --git a/include/linux/poll_source.h b/include/linux/poll_source.h
> > new file mode 100644
> > index 000000000000..ccfb424e170b
> > --- /dev/null
> > +++ b/include/linux/poll_source.h
> > @@ -0,0 +1,53 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +/*
> > + * poll_source.h - cpuidle busy waiting API
> > + */
> > +#ifndef __LINUX_POLLSOURCE_H__
> > +#define __LINUX_POLLSOURCE_H__
> > +
> > +#include <linux/list.h>
> > +
> > +struct poll_source;
> > +
> > +struct poll_source_ops {
> > +	void (*start)(struct poll_source *src);
> > +	void (*stop)(struct poll_source *src);
> > +	void (*poll)(struct poll_source *src);
> > +};
> > +
> > +struct poll_source {
> > +	const struct poll_source_ops *ops;
> > +	struct list_head node;
> > +	int cpu;
> > +};
> > +
> > +/**
> > + * poll_source_register - Add a poll_source for a CPU
> > + */
> > +#if defined(CONFIG_CPU_IDLE) && defined(CONFIG_ARCH_HAS_CPU_RELAX)
> > +int poll_source_register(struct poll_source *src);
> > +#else
> > +static inline int poll_source_register(struct poll_source *src)
> > +{
> > +	return 0;
> > +}
> > +#endif
> > +
> > +/**
> > + * poll_source_unregister - Remove a previously registered poll_source
> > + */
> > +#if defined(CONFIG_CPU_IDLE) && defined(CONFIG_ARCH_HAS_CPU_RELAX)
> > +int poll_source_unregister(struct poll_source *src);
> > +#else
> > +static inline int poll_source_unregister(struct poll_source *src)
> > +{
> > +	return 0;
> > +}
> > +#endif
> > +
> > +/* Used by the cpuidle driver */
> > +void poll_source_start(void);
> > +void poll_source_run_once(void);
> > +void poll_source_stop(void);
> > +
> > +#endif /* __LINUX_POLLSOURCE_H__ */
> > diff --git a/drivers/cpuidle/poll_source.c b/drivers/cpuidle/poll_sourc=
e.c
> > new file mode 100644
> > index 000000000000..46100e5a71e4
> > --- /dev/null
> > +++ b/drivers/cpuidle/poll_source.c
> > @@ -0,0 +1,99 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * poll_source.c - cpuidle busy waiting API
> > + */
> > +
> > +#include <linux/lockdep.h>
> > +#include <linux/percpu.h>
> > +#include <linux/poll_source.h>
> > +
> > +/* The per-cpu list of registered poll sources */
> > +DEFINE_PER_CPU(struct list_head, poll_source_list);
> > +
> > +/* Called from idle task with TIF_POLLING_NRFLAG set and irqs enabled =
*/
> > +void poll_source_start(void)
> > +{
> > +	struct poll_source *src;
> > +
> > +	list_for_each_entry(src, this_cpu_ptr(&poll_source_list), node)
> > +		src->ops->start(src);
> > +}
> > +
> > +/* Called from idle task with TIF_POLLING_NRFLAG set and irqs enabled =
*/
> > +void poll_source_run_once(void)
> > +{
> > +	struct poll_source *src;
> > +
> > +	list_for_each_entry(src, this_cpu_ptr(&poll_source_list), node)
> > +		src->ops->poll(src);
> > +}
> > +
> > +/* Called from idle task with TIF_POLLING_NRFLAG set and irqs enabled =
*/
> > +void poll_source_stop(void)
> > +{
> > +	struct poll_source *src;
> > +
> > +	list_for_each_entry(src, this_cpu_ptr(&poll_source_list), node)
> > +		src->ops->stop(src);
> > +}
> > +
> > +static void poll_source_register_this_cpu(void *opaque)
> > +{
> > +	struct poll_source *src =3D opaque;
> > +
> > +	lockdep_assert_irqs_disabled();
> > +
> > +	list_add_tail(&src->node, this_cpu_ptr(&poll_source_list));
> > +}
> > +
> > +int poll_source_register(struct poll_source *src)
> > +{
> > +	if (!list_empty(&src->node))
> > +		return -EBUSY;
> > +
> > +	/*
> > +	 * There is no race with src->cpu iterating over poll_source_list
> > +	 * because smp_call_function_single() just sets TIF_NEED_RESCHED
>=20
> Hum... what about=20
>=20
> CPU-0				CPU-1
>=20
> poll_source_start		poll_source_register IPI'ing CPU-0
>=20
> Perhaps a llist can be used?

The simplest solution might be queue_work_on(src->cpu, system_hipri_wq,
&work) plus a completion. That way we know poll_source_start/stop/run()
are not executing and there can be no re-entrancy issues. The nice thing
is it's simple - no low-level tricks.

Those are the semantics I wanted with smp_call_function_single() but I
think I chose the wrong API :).

> >               while (!need_resched()) {
> > +                     poll_source_run_once();
>=20
> Probably want to use static_key's for ->start, ->stop and ->poll?

Good idea, thanks.

Stefan

--b+tZ28pnN4/86HI2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmD22nMACgkQnKSrs4Gr
c8jZDwf7BqmVXu7enG1aKFj2iNw87zAu9vpvvkJShcweSX/NysL8N2e5yH3hWk+L
KU4y8WMqfSyg1SGBXFXmwFsNFU+No7bzKvf9Cf2t0bGpPSHFkczM68tfebLH5V6a
hTd8wpmEpgHGCfUQ3Hs7eVLNgWBou2LDTdj1p3UlHj7R+HwgftV1XdPIPoV9QlmW
UYDfr3TzU1BLZP75UpXRRBuD8woatGKwJe+ekACvRuhkpyk33DFWTAFVdTsKQo8R
pZVZVszNrusbnecNDyIedQfZwKb6fermp/3fTLLGtuoUzC+cgrHvh6bKHHiIeLYZ
qMlohBaoCZQ2zhgxRH0LdBAxwMpnrg==
=U74T
-----END PGP SIGNATURE-----

--b+tZ28pnN4/86HI2--

