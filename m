Return-Path: <linux-pm+bounces-24618-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D61A75E23
	for <lists+linux-pm@lfdr.de>; Mon, 31 Mar 2025 05:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 210C61670CD
	for <lists+linux-pm@lfdr.de>; Mon, 31 Mar 2025 03:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7766113C914;
	Mon, 31 Mar 2025 03:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JEwFdcXb"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392E482866
	for <linux-pm@vger.kernel.org>; Mon, 31 Mar 2025 03:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743391353; cv=none; b=VJoKrKQ+RU/vcbY3gK7F+mNOTbGZyktnOAlu9+vIk8qZSJkYv3avSLhnDfAWEUzxahQxUHFeyHUMoS4UZpiJwDvS6pD9B7CpfAt7xsAM9iKjts8S46FVo/Qmh3arXla8/5KfLIwfbNNFYGiVm91pSU9PhGg7Cypsf8bIpd0kzZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743391353; c=relaxed/simple;
	bh=DJYht588chhOshnh/oM01PQlP9cicgLlbkkCnh6ie10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TqeAZtJPqQKJI7bb7W4cHcnoQ6GtMWHP12JkZOFr0VqUplegkN38HXlr7OJ4oUSzls9Wxk5KPN3lwTEz1dsXRJDbxYcFGtGnCQF8ct3dqnJwEciNKY2mdTTQoOOOmwEMtKCqft00NLhUdrLzdbsoaZzd7pUbmaORZy+q/PEwb+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JEwFdcXb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743391350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DJYht588chhOshnh/oM01PQlP9cicgLlbkkCnh6ie10=;
	b=JEwFdcXb4BArWGTfnD66tLS2NLniPug8c+GfVlIKCyX0Pyal/Ej5qMxiy246hnHuwrifTc
	5NSJBFshaxssi3LlV4mGg66NuA3LDzdmgFAVioTdEaD04rCeXW+TG8mrevPovsJx/Cj5/7
	xVqQnvPjQNfNmQiOZX2kOH9hFrrnPLI=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-JoukL7YrO62CflzW5sm7qA-1; Sun, 30 Mar 2025 23:22:28 -0400
X-MC-Unique: JoukL7YrO62CflzW5sm7qA-1
X-Mimecast-MFC-AGG-ID: JoukL7YrO62CflzW5sm7qA_1743391348
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d44dc8a9b4so40311365ab.3
        for <linux-pm@vger.kernel.org>; Sun, 30 Mar 2025 20:22:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743391348; x=1743996148;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DJYht588chhOshnh/oM01PQlP9cicgLlbkkCnh6ie10=;
        b=umGUpHiHRRm6rtzyl0eszc7BHRRAik1cbqsw51rUdFz/KvJJEOyjH5VDBmY3ieY8vO
         nYGpp/cnS9StV1Yy7ZlSV4JDt56js2xRpsQ9GYe2+yULQul28Eko1qW4Jp1wwO/1TCx0
         mLsV4aEzlKoToCDF6Q2pn9AIssFgVCyF36sDqU1yOwkiQw1BapISs/lKo2M4UrpPwlBm
         D0+KE0QgsrUIFmq2mnlTXi/c9woZpBMeTaZvCf2ilLXw3KqQDhItvrlgZk5zWyd600AR
         +bH7nOPZeaPHDI1C7yvw1G25UqxPQ4rweFWjPhMC4ICKjERBwiu5EORf83r1wmGCrb6t
         qkvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUclFFEtG8IFrbPBBOs6JG0NilfT7ahzB53mpUPxPd+94eFeLicdMjlVzZbnIvXwDNl+qfqED56Gg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4kIC4vBhbnPpaqghym8QhktJhwFUVu7NRwi4ogaVnsukr/5Lw
	O5QyeXcIkZzBudGvbnNCtfUWOXMB75kg6RzyWK5otySXmOc4ku1fIBsBEnO64t4fRBjIpWSiGeE
	61vO6IBz1jODYh3PPvOc+Qe4E/xRtNloC4sGbZAJ5SgYOniA8qmQ2K4WTFP8g2NDsdS8jQeLHcI
	QoKFTTmb7zSoqxYLJZUrQhz3T87stv4T0=
X-Gm-Gg: ASbGncvogJJR6swu6vuL6u/6lrz2nwK3FjwsMPqFzS05AV4zTwKwQR3pSUtIeUzK5d7
	A3vnopub9vw+rQJ3n58K08/LQ2xeY89/EGC9kMyMA98ALdH8as0qIr04TYzdCEuXZOQK9nYGRKA
	==
X-Received: by 2002:a05:6e02:17ce:b0:3a7:820c:180a with SMTP id e9e14a558f8ab-3d5e0a093b2mr79161025ab.19.1743391347967;
        Sun, 30 Mar 2025 20:22:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzaH25Vzm7n70KpLV36fle/W5sj7NSSdA8hJmo754X2wtwvaPhuyZSC58LigxxsFYAU0bQlbQf86JZovKBAVI=
X-Received: by 2002:a05:6e02:17ce:b0:3a7:820c:180a with SMTP id
 e9e14a558f8ab-3d5e0a093b2mr79160885ab.19.1743391347656; Sun, 30 Mar 2025
 20:22:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z4WFjBVHpndct7br@desktop0a> <Z5bx7ZHNcyc5fM_L@darkstar.users.ipa.redhat.com>
 <CALu+AoSSKh=5ELgQyzDrGEDm5fm2XKteH1ZC70mm89pNSSPMHw@mail.gmail.com>
 <Z-c7V2hptt9U9UCl@desktop0a> <Z+dQZozsbdls6yqJ@MiWiFi-R3L-srv> <Z-hYWc9LtBU1Yhtg@desktop0a>
In-Reply-To: <Z-hYWc9LtBU1Yhtg@desktop0a>
From: Dave Young <dyoung@redhat.com>
Date: Mon, 31 Mar 2025 11:22:50 +0800
X-Gm-Features: AQ5f1Jq_A3xmC-EmSPquFgYtTSaWdlNOr-d-et357PEEYRDXHWaZEck-6AeRlpk
Message-ID: <CALu+AoTrPZS7ukuLsCTCwKNKVd8=PUN8nXwh9BdicyV-==-W=g@mail.gmail.com>
Subject: Re: [REGRESSION] Kernel booted via kexec fails to resume from hibernation
To: Roberto Ricci <io@r-ricci.it>
Cc: Baoquan He <bhe@redhat.com>, ebiederm@xmission.com, rafael@kernel.org, pavel@ucw.cz, 
	ytcoode@gmail.com, kexec@lists.infradead.org, linux-pm@vger.kernel.org, 
	akpm@linux-foundation.org, regressions@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> With v4.9.337, kexec (via kexec_load) + hibernation works.
> With v5.4.291 it doesn't.
> I'm not sure how bisection could be done in this case.
>

Not confident, but maybe you can try latest mainline kernel see if the
below commit helps:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a2498e5c453b3d8d054d77751487cd593332f8c2

I noticed the e820 export is different for v4.9.337 and v5.4.291

Thanks
Dave


