Return-Path: <linux-pm+bounces-43882-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDPUNCQ9q2n7bQEAu9opvQ
	(envelope-from <linux-pm+bounces-43882-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 21:46:28 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6622279D5
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 21:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AB0EB30095C3
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 20:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D4B48164C;
	Fri,  6 Mar 2026 20:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="phk0fw+J"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BDA35E942
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 20:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772829983; cv=none; b=roiKvizaMJCy320gRxt0GSgeiEK1oWCppRZKMINYDH51rqCQaKj+0/dwY+IO3isMlWSCRdw7Te2D/Tao3974cdQ/+UtzbzdT6QIzL8fDa1J1dfh4zoK7uftfO4xnwarEUV033TZs/VH8IAoMqL4YBvLcJv4v/fRq39xRUxt/jyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772829983; c=relaxed/simple;
	bh=YR03A36g/qiuwB5XBPpJJN25fkqroyaXGPCRgXfTigE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fOhdx+E6awUYQ1vTrCnzGOw78Ty3vjzfGTSHjC9rKwsq93+Dkvttob9g6Ez3M2Uuejr47lC3wQ+kkQVC8TWtZRGW08x1+IoO13FjsGeheQ8CcnJPikN9ojp+63stmFeaoUWEGldgWn3VLdW+7ODpUC+wJviXT1Y7BQQSjizrdo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=phk0fw+J; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 5FC44240103
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 21:46:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1772829980; bh=2iaC+pQxbZxpQoXRMUqKToJTmZXkRZTNoMlTI0V8Hnw=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=phk0fw+J2DkqY919TIIAsyR+a+Rtz4/lr1nuk/ouG3opB6VJdC8rzSClPyt+8vQN4
	 i1JBf/paRzFBWcL3jwYwhValdnSWIqcm/1jFQSPNh0LQZ0dcHz0xXganj1ZGKOC9On
	 0uEyYF0rZz9miXFNJiWl65+O91yLCTdcFfLo4jF/WDlAxCWDCPYqKSX/x5eXJsFgdl
	 5PObe5/dzLfp+N3MZER89yroJWHeGlYy/u+aJiDAcx7Nwkbymz9c2H5vUrocePsg6H
	 NoDUpfYqG2M/iv/eh4huzkktUvkkgEjmPWqhld0A0VCfVMvhfUNuViCgn0AZsnlTFI
	 RmM+pU8lnW/7w==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4fSJN963Qyz6twG;
	Fri,  6 Mar 2026 21:46:17 +0100 (CET)
Message-ID: <ecb158925934c38bf044adcbacadb920300d35dc.camel@posteo.de>
Subject: Re: [PATCH v2 3/4] rust: add basic serial device bus abstractions
From: Markus Probst <markus.probst@posteo.de>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman	
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Miguel
 Ojeda	 <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <lossin@kernel.org>, Andreas Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross	 <tmgross@umich.edu>, Kari Argillander
 <kari.argillander@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Boqun Feng <boqun@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-serial@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, 	linux-pm@vger.kernel.org,
 driver-core@lists.linux.dev, 	dri-devel@lists.freedesktop.org
Date: Fri, 06 Mar 2026 20:46:19 +0000
In-Reply-To: <DGVZNDKJ7RAG.A66CR0EV9T3P@kernel.org>
References: <20260306-rust_serdev-v2-0-e9b23b42b255@posteo.de>
	 <20260306-rust_serdev-v2-3-e9b23b42b255@posteo.de>
	 <DGVZNDKJ7RAG.A66CR0EV9T3P@kernel.org>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=mQINBGiDvXgBEADAXUceKafpl46S35UmDh2wRvvx+UfZbcTjeQOlSwKP7YVJ4JOZrVs93
 qReNLkOWguIqPBxR9blQ4nyYrqSCV+MMw/3ifyXIm6Pw2YRUDg+WTEOjTixRCoWDgUj1nOsvJ9tVA
 m76Ww+/pAnepVRafMID0rqEfD9oGv1YrfpeFJhyE2zUw3SyyNLIKWD6QeLRhKQRbSnsXhGLFBXCqt
 9k5JARhgQof9zvztcCVlT5KVvuyfC4H+HzeGmu9201BVyihJwKdcKPq+n/aY5FUVxNTgtI9f8wIbm
 fAjaoT1pjXSp+dszakA98fhONM98pOq723o/1ZGMZukyXFfsDGtA3BB79HoopHKujLGWAGskzClwT
 jRQxBqxh/U/lL1pc+0xPWikTNCmtziCOvv0KA0arDOMQlyFvImzX6oGVgE4ksKQYbMZ3Ikw6L1Rv1
 J+FvN0aNwOKgL2ztBRYscUGcQvA0Zo1fGCAn/BLEJvQYShWKeKqjyncVGoXFsz2AcuFKe1pwETSsN
 6OZncjy32e4ktgs07cWBfx0v62b8md36jau+B6RVnnodaA8++oXl3FRwiEW8XfXWIjy4umIv93tb8
 8ekYsfOfWkTSewZYXGoqe4RtK80ulMHb/dh2FZQIFyRdN4HOmB4FYO5sEYFr9YjHLmDkrUgNodJCX
 CeMe4BO4iaxUQARAQABtCdNYXJrdXMgUHJvYnN0IDxtYXJrdXMucHJvYnN0QHBvc3Rlby5kZT6JAl
 QEEwEIAD4CGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQSCdBjE9KxY53IwxHM0dh/4561
 D0gUCaIZ9HQIZAQAKCRA0dh/4561D0pKmD/92zsCfbD+SrvBpNWtbit7J9wFBNr9qSFFm2n/65qen
 NNWKDrCzDsjRbALMHSO8nigMWzjofbVjj8Nf7SDcdapRjrMCnidS0DuW3pZBo6W0sZqV/fLx+AzgQ
 7PAr6jtBbUoKW/GCGHLLtb6Hv+zjL17KGVO0DdQeoHEXMa48mJh8rS7VlUzVtpbxsWbb1wRZJTD88
 ALDOLTWGqMbCTFDKFfGcqBLdUT13vx706Q29wrDiogmQhLGYKc6fQzpHhCLNhHTl8ZVLuKVY3wTT+
 f9TzW1BDzFTAe3ZXsKhrzF+ud7vr6ff9p1Zl+Nujz94EDYHi/5Yrtp//+N/ZjDGDmqZOEA86/Gybu
 6XE/v4S85ls0cAe37WTqsMCJjVRMP52r7Y1AuOONJDe3sIsDge++XFhwfGPbZwBnwd4gEVcdrKhnO
 ntuP9TvBMFWeTvtLqlWJUt7n8f/ELCcGoO5acai1iZ59GC81GLl2izObOLNjyv3G6hia/w50Mw9MU
 dAdZQ2MxM6k+x4L5XeysdcR/2AydVLtu2LGFOrKyEe0M9XmlE6OvziWXvVVwomvTN3LaNUmaINhr7
 pHTFwDiZCSWKnwnvD2+jA1trKq1xKUQY1uGW9XgSj98pKyixHWoeEpydr+alSTB43c3m0351/9rYT
 TTi4KSk73wtapPKtaoIR3rOFHLQXbWFya3VzLnByb2JzdEBwb3N0ZW8uZGWJAlEEEwEIADsWIQSCd
 BjE9KxY53IwxHM0dh/4561D0gUCaIO9eAIbAwULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgAAKCR
 A0dh/4561D0oHZEACEmk5Ng9+OXoVxJJ+c9slBI2lYxyBO84qkWjoJ/0GpwoHk1IpyL+i+kF1Bb7y
 Hx9Tiz8ENYX7xIPTZzS8hXs1ksuo76FQUyD6onA/69xZIrYZ0NSA5HUo62qzzMSZL7od5e12R6OPR
 lR0PIuc4ecOGCEq3BLRPfZSYrL54tiase8HubXsvb6EBQ8jPI8ZUlr96ZqFEwrQZF/3ihyV6LILLk
 geExgwlTzo5Wv3piOXPTITBuzuFhBJqEnT25q2j8OumGQ+ri8oVeAzx24g1kc11pwpR0sowfa5MvZ
 WrrBcaIL7uJfR/ig7FyGnTQ1nS3btf3p0v8A3fc4eUu/K2No3l2huJp3+LHhCmpmeykOhSB63Mj3s
 3Q87LD0HE0HBkTEMwp+sD97ZRpO67H5shzJRanUaDTb/mREfzpJmRT1uuec0X2zItL7a6itgMJvYI
 KG29aJLX3fTzzVzFGPgzVZYEdhu4y53p0qEGrrC1JtKR6DRPE1hb/OdWOkjmJ75+PPLD9U5IuRd6y
 sHJWsEBR1F0wkMPkEofWsvMYJzWXx/rvTWO8N4D6HigTgBXAXNgbc3IHpHlkvKoBJptv6DRVRtIrz
 0G0cfBY0Sm7he4N2IYDWWdGnPBZ3rlLSdj5EiBU2YWgIgtLrb8ZNJ3ZlhYluGnBJDGRqy2jC9s1jY
 66sLA9rQZMHhJTzMyIDwweGlvMzJAcG9zdGVvLmV1PokCbQQTAQgAVxYhBIJ0GMT0rFjncjDEczR2
 H/jnrUPSBQJpa71VGxSAAAAAAAQADm1hbnUyLDIuNSsxLjExLDIsMgIbAwULCQgHAgIiAgYVCgkIC
 wIEFgIDAQIeBwIXgAAKCRA0dh/4561D0gKJD/9uOQKYlsDoQX65Gd0LiMT0C+5vXgr3VI0PHDOwcv
 51fJ3A1vNyPZRFPGrz8+mDEXUQOF/INfnz5Tu1QHwf+iYcWcTGAN/FHgVR6ET6VBNU2hJaKhu+Ggo
 kjYyJTOvyX+3yNRUfSny0GjTjIPuPTErjqmHF+BtjXslpgwqnNMznf3lRIuUjRORupos6p3k1DndE
 5vzUTmXSvMyXyOD2KhBl/kL76k0bHYyAQytZPag12pltrtFbA/r2phDGN2si8PooDT99bSTJjaM45
 MTAAHbHKJfvgfK41bNFD5mMtpWpL195XRtS0Nrxdg3PaYBxN5gtTG0RyZfpYRlkdEhm+jj/8RxuSG
 i/qdhRdbiI7K2IELWeQVHSNDi9JabR/UzlR4NSnhfAjRIVlRM+eFbUl8XwxwVrAkojF5IraH2qRvg
 VCmuFsHUW07FUlrDrzpjXsD73cKppoFGDCdDR0BHJepXbFLS9+AqkT+guRJlnCTg2p+TQtnbwPgKp
 Vj98JixovCl99zRYTsL2bRNU5+q8iET65VMJ1ydyNanvLd5vI/NqDkXhlXLsGmdaDTtu4R21PkToX
 dQNGrZ91M9nlIBKw8Y7c7xZ4098qX2b8JX/CxD+gC1r4C8vuA3GkhFLx+KlkON7LyiJPkrePp6Qky
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-o/KXAoogandmA1L4aMdF"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt
X-Rspamd-Queue-Id: DB6622279D5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[posteo.de,none];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[posteo.de:s=2017];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linuxfoundation.org,garyguo.net,protonmail.com,google.com,umich.edu,gmail.com,linaro.org,ffwll.ch,vger.kernel.org,lists.linux.dev,lists.freedesktop.org];
	TAGGED_FROM(0.00)[bounces-43882-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[posteo.de:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.probst@posteo.de,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,posteo.de:dkim,posteo.de:mid]
X-Rspamd-Action: no action


--=-o/KXAoogandmA1L4aMdF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-03-06 at 21:40 +0100, Danilo Krummrich wrote:
> On Fri Mar 6, 2026 at 8:35 PM CET, Markus Probst wrote:
> > +    extern "C" fn receive_buf_callback(
> > +        sdev: *mut bindings::serdev_device,
> > +        buf: *const u8,
> > +        length: usize,
> > +    ) -> usize {
> > +        // SAFETY: The serial device bus only ever calls the receive b=
uf callback with a valid
> > +        // pointer to a `struct serdev_device`.
> > +        //
> > +        // INVARIANT: `sdev` is valid for the duration of `receive_buf=
_callback()`.
> > +        let sdev =3D unsafe { &*sdev.cast::<Device<device::CoreInterna=
l>>() };
> > +
> > +        // SAFETY: `receive_buf_callback` is only ever called after a =
successful call to
> > +        // `probe_callback`, hence it's guaranteed that `Device::set_d=
rvdata()` has been called
> > +        // and stored a `Pin<KBox<T>>`.
> > +        let data =3D unsafe { sdev.as_ref().drvdata_borrow::<T>() };
> > +
> > +        // SAFETY:
> > +        // - The serial device bus only ever calls the receive buf cal=
lback with a valid pointer to
> > +        //   a `struct serdev_device`.
> > +        // - `receive_buf_callback` is only ever called after a succes=
sful call to
> > +        //   `probe_callback`, hence it's guaranteed that `sdev.privat=
e_data` is a pointer
> > +        //   to a valid `PrivateData`.
> > +        let private_data =3D unsafe { &*(*sdev.as_raw()).private_data.=
cast::<PrivateData>() };
> > +
> > +        private_data.probe_complete.complete_all();
>=20
> Will do a full review pass later on, but one quick question in advance:
>=20
> What is this used for? It is completed here and in probe(), but I don't s=
ee it ever
> being used to actually wait.
Uh, thats a typo. It is supposed to wait here in receive_buf_callback.

Thanks
- Markus Probst

>=20
> > +
> > +        // SAFETY: No one has exclusive access to `private_data.error`=
.
> > +        if unsafe { *private_data.error.get() } {
> > +            return length;
> > +        }
> > +
> > +        // SAFETY: `buf` is guaranteed to be non-null and has the size=
 of `length`.
> > +        let buf =3D unsafe { core::slice::from_raw_parts(buf, length) =
};
> > +
> > +        T::receive(sdev, data, buf)
> > +    }
> > +}

--=-o/KXAoogandmA1L4aMdF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmmrPRcbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyAAoJEDR2H/jnrUPSWVEP/1ag22PV+effqCIXNtIi
ojhUChzfy4ZFNQt7RTYHSrKwzWk0LWTMbCrEH2S818Rbhhwb8xVGLKFOujTKFx/0
RhnYaiCBCa5LmYRcSLIvp4cf9DLR547L9kAIQEbqZ0UaXyINt1sIKm9A17R28Zo8
JKu+Z57BkfSEn65N0E5w9xcHpzlBx7dK1zp0vLCWT/6GM1uXLwJQ5RYIP0ejcVpc
xWKbwcLjPY6Wc35tIHOgTW4kJyQOBfNkO7flQn4kZvvnnVqwJz/bVl6TWH93s94H
np6fggCna/m1JmOklY4MQVPLnLrDAAOSEWVZTytEXH6gYnOCbpYqwIdKiDrbTQKz
Hki4V/ytUtSvoCtsoj53rPqawbTGP1dBCgcnNZwOf64h4HqY1UGqWGfriRFvczB+
DuHAndPRI/doaHzm7u/jXmVKjhHIfq1QByvF5n2JEii0YtqvFFqJ/+IOcQLewugx
p8DUTAhPTLsXwfsuy/D4hgfpJVayXdnGxA7L8IUMbFyMnNS+8qwGSn0OkIfZbQIi
1zpi2P2FUwAB+YpEGxoI9r9cDSl0TckIoTny8BZskbzb6ZCZP9mB2Ie095UJbP3s
BauRToFJ+KZi67Z8V4ooNgREBKEECBlxxs4aVPCo2lIHvW8aftj2riSq5Gy4hIgD
rznZ+gd+0JDfXZFuGhtCi5SM
=HjzS
-----END PGP SIGNATURE-----

--=-o/KXAoogandmA1L4aMdF--

