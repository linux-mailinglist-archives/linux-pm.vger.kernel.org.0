Return-Path: <linux-pm+bounces-17071-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 559999BEB96
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 13:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14DD0284EF2
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 12:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5E11F8907;
	Wed,  6 Nov 2024 12:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b/DZp64n"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEB61F81B1
	for <linux-pm@vger.kernel.org>; Wed,  6 Nov 2024 12:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730897163; cv=none; b=oHEbGtbQB8Low4w/mnO8CMpxRRjBAnMJSsNyK/T0LQ8iOFxymwdnbBX4n7A4ayLnzdisIK0gvLSE6RM9Zyw8FpMozQomIIKoEbJyxUGi1ACmE/6yssBs5q4f6Wh7en3wThxb2SSjgIOH43Ybr4/tcAdhHPY3z1GP2TQqevq/DWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730897163; c=relaxed/simple;
	bh=oZEJpWFGDHrs92+9VxEMzdkrrPrA1W8Jk3Vu/SgYHOs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VDLV4YhoA5hKCohVRcuS35RLLBmg7JLQlu7HdT4ZXSON4XBZpkxW9GP0Mnm28MO+x63yYhTdpfSmJ0voOxWYdxVoQBBl55JqktV9eM05CrvW9TJGSrEL7e9tMoaJ7iWUzSNCBt3AOATgWltFj9w0j8fgK/zXLlvirm7lYLfio9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b/DZp64n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730897160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hNg/n323bdqLDvtiYjZOYqtT4/DprftsEjfi06zMFo4=;
	b=b/DZp64nFRIidN/7BeVPdDtgQhCoE396tuCojdBZL/04HrGdXxXlbFtGq5Z+KT/pqYYD7r
	ZHaOXoMLr+xZwZw9ASC+qsyslSA6/BNhd2/+s96rByNVhjCIOsZoRIMQjffzx9YdRqpEXm
	zg5E0MBiQ82DCC5QYbuqLl3QuLZpCSk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-K1sm1SxLN4SaqN15XMR-GA-1; Wed, 06 Nov 2024 07:45:59 -0500
X-MC-Unique: K1sm1SxLN4SaqN15XMR-GA-1
X-Mimecast-MFC-AGG-ID: K1sm1SxLN4SaqN15XMR-GA
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4316e350d6aso44038865e9.3
        for <linux-pm@vger.kernel.org>; Wed, 06 Nov 2024 04:45:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730897158; x=1731501958;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hNg/n323bdqLDvtiYjZOYqtT4/DprftsEjfi06zMFo4=;
        b=d6kIWXUPtBTlZNEDpuclIDj8sQbmp2zyhO+X7VFuc7hpXWX2tEL/7rb+8iBpybsJ7E
         56CTmAkDirkQSOXoUkGuEv/kdDdDOZrXX0wBT03FBlqQSu5zuMB4Cy8+G/xGN/z/9hJd
         rD70pjMaisdArP1q6BxmD6vbRWlGfXaKlFxNKVs21mVKfRhFDz2iUCaAXmF2pxdWdmcz
         Hrwx/QB2hpRYEZOdFzWoIEDCCHQtC/MJXwdDS2m50zTbYZOjosEhYGlImxekIEKMd2tz
         B+F4PMYggBZUtFTzCrhJ0SxzeQWxWooBWRLGlIUf/4SVUh4r/hIeg578bMfp7aaFsBPf
         Extw==
X-Gm-Message-State: AOJu0YxrFIkl5wXhYgkIuyK7UVu2JebHTaNaq8N0EbIr3FP/NaGnQ4Ze
	yGzSioeBga1ioWEeVJY4EdBr6cJPE6Gi5upwwz45mYRUlv/hSRZqS4Phj+om2TxePl2CxgamAP9
	Pion4NO2b/23bW0rNDNR2JcfG4NH9NZNreuN8sYF8oK0I9kRW07KN0Icl2sGbulRw2FcJJ08byg
	1ks3zb6lbBH5aMpM+QgDnzu6rBmflAy2a+X51Uj7gjGZiA1g==
X-Received: by 2002:a05:600c:45ce:b0:431:4f29:9542 with SMTP id 5b1f17b1804b1-4328323f81amr157382855e9.6.1730897157728;
        Wed, 06 Nov 2024 04:45:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQfzB4j6wZKp9l6UIeDmRJ4LIJfr9Pqvgh4gQlUv5xd8QSovnwaJl6hUPwGQpd2nurQexrTg==
X-Received: by 2002:a05:600c:45ce:b0:431:4f29:9542 with SMTP id 5b1f17b1804b1-4328323f81amr157382555e9.6.1730897157284;
        Wed, 06 Nov 2024 04:45:57 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.142.6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa6b60e9sm21059855e9.14.2024.11.06.04.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 04:45:56 -0800 (PST)
Date: Wed, 6 Nov 2024 13:45:54 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Juri Lelli <juri.lelli@redhat.com>,
	Frauke =?iso-8859-1?Q?J=E4ger?= <frauke@linutronix.de>,
	Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
Subject: [ANNOUNCE][CFP] Power Management and Scheduling in the Linux Kernel
 VII edition (OSPM-summit 2025)
Message-ID: <ZytlAkTiuZApK23Y@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Power Management and Scheduling in the Linux Kernel (OSPM-summit) VII edition

March 18-20, 2025
Alte Fabrik
Uhldingen-Mühlhofen, Germany

---

.:: FOCUS

OSPM is moving to Germany!

The VII edition of the Power Management and Scheduling in the Linux
Kernel (OSPM) summit aims at fostering discussions on power management
and (real-time) scheduling techniques. Summit will be held in Uhldingen
(Germany) on March 18-20, 2025.

We welcome anybody interested in having discussions on the broad scope
of scheduler techniques for reducing energy consumption while meeting
performance and latency requirements, real-time systems, real-time and
non-real-time scheduling, tooling, debugging and tracing.

Feel free to take a look at what happened previous years:

 I   edition - https://lwn.net/Articles/721573/
 II  edition - https://lwn.net/Articles/754923/
 III edition - https://lwn.net/Articles/793281/
 IV  edition - https://lwn.net/Articles/820337/ (online)
 V   edition - https://lwn.net/Articles/934142/
               https://lwn.net/Articles/934459/
               https://lwn.net/Articles/935180/
 VI  edition - https://lwn.net/Articles/981371/

.:: FORMAT

The summit is organized to cover three days of discussions and talks.

The list of topics of interest includes (but it is not limited to):

 * Power management techniques
 * Scheduling techniques (real-time and non real-time)
 * Energy consumption and CPU capacity aware scheduling
 * Real-time virtualization
 * Mobile/Server power management real-world use cases (successes and
   failures)
 * Power management and scheduling tooling (configuration, integration,
   testing, etc.)
 * Tracing
 * Recap/lightning talks

Presentations (50 min) can cover recently developed technologies,
ongoing work and new ideas. Please understand that this workshop is not
intended for presenting sales and marketing pitches.

.:: SUBMIT A TOPIC/PRESENTATION

To submit a topic/presentation use the form available at
https://forms.gle/Vbvpxsh8pqBffx8b6.

Or, if you prefer, simply reply (only to me, please :) to this email
specifying:

- name/surname
- affiliation
- short bio
- email address
- title
- abstract

Deadline for submitting topics/presentations is December 9, 2024.
Notifications for accepted topics/presentations will be sent out
December 16, 2024.

.:: ATTENDING

Attending the OSPM-summit is free of charge, but registration to the
event is mandatory. The event can allow a maximum of 50 people (so, be
sure to register early!).

Registrations open on December 16, 2024.
To register fill in the registration form available at
https://forms.gle/Yvk7aS79pvNR6hbv8.

While it is not strictly required to submit a topic/presentation,
registrations with a topic/presentation proposal will take precedence.

.:: VENUE

The conference will take place at Alte Fabrik [1], Daisendorfer Str. 4,
88689 Uhldingen-Mühlhofen, Germany

The conference venue is located in a 2 minute walking distance [2] to
the Hotel Sternen [3] that has been pre-reserved for the participants.
Since it is a very rural area, we recommend booking this hotel as it is
close to the conference room. The price ranges per night incl. breakfast
between 85€ (Standard Single Room) up to 149€ (Junior Suite). There is
an availability of 37 rooms in the hotel. Another 13 rooms are
pre-reserved in the Hotel Kreuz which is also a 5min walking distance to
the conference location [4]. Cost is 75€ inkl. breakfast. Please choose
your hotel (and room) and arrange booking yourself. We recommend arrival
on March 17 and departure on March 21 due to the length of the trip.

Please use the code ‘LINUTRONIX’ when booking your hotel room. 
Deadline for hotel booking in Hotel Sternen is February 28, 2025.
Deadline for hotel booking in Hotel Kreuz is January 17, 2025.  
After these dates, cancellations are not free of charge anymore.

You can reach Uhldingen-Mühlhofen best from Zürich Airport [5] or
Friedrichshafen Airport [6]. From both airports there are train and/or
bus connections to Uhldingen-Mühlhofen which you can check here [7]. The
rides are quite long, so another possibility is to organize yourself in
groups and share a taxi/shuttle [8].

[1] https://www.fabrik-muehlhofen.de/
[2] https://maps.app.goo.gl/S6cnTgx1KJAGRkMr7
[3] https://www.steAlte Fabrik Mühlhofenrnen-muehlhofen.de/
[4] https://www.bodensee-hotel-kreuz.de/
[5] https://www.flughafen-zuerich.ch/de/passagiere/praktisches/parking-und-transport/zug-tram-und-bus
[6] https://www.bodensee-airport.eu/passagiere-besucher/anreise-parken-uebernachten/
[7] https://www.bahn.de/
[8] https://airporttaxi24.ch/?gad_source=1&gclid=EAIaIQobChMIo_y9l56iiQMVfp6DBx16NxPtEAAYAiAAEgJOO_D_BwE

.:: ORGANIZERS

Juri Lelli (Red Hat)
Frauke Jäger (Linutronix)
Tommaso Cucinotta (SSSA)
Lorenzo Pieralisi (Linaro)


