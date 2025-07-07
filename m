Return-Path: <linux-pm+bounces-30303-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA27AFB8C6
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 18:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 807F8167090
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 16:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B2622A7FC;
	Mon,  7 Jul 2025 16:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="hFrg47bn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF002264D7
	for <linux-pm@vger.kernel.org>; Mon,  7 Jul 2025 16:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751906320; cv=none; b=I/bWY4JUlsbJgcHpLchW1imBPPzuE136G5GWZHWEd5IoKPPHK4uxxuWaWKJEtFG0sJcwT3wzOL1YNfVzCc2k92FfRXd4dlFACFWN/Hgykbb1+TMDR8U5Uaq70F16yvpUqemdu80j9eQlinVKyX+l1U4McumDnc8lTs/yxi42lbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751906320; c=relaxed/simple;
	bh=S3amwlujUkc5UJJ8aquZiBQnf83DeXQQ7Cd8Fx38bII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFZTSQx7zccSlNwtHsfc8RIQmP7Tc7F7sHi8pdsqtK1ft9qu3NOM0xFmMf7eoDnOolUT1cVlglbjvXSf0fLJJ2/QQEKLJS+B/JvgIuU8oJ9NWu2mvSy7ZsY4ExKMiqGHxpBqWILwQVRBwDlu3OfDdaW8T0DEg6hLp30g3gF+Flk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=hFrg47bn; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45363645a8eso23691805e9.1
        for <linux-pm@vger.kernel.org>; Mon, 07 Jul 2025 09:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751906316; x=1752511116; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S3amwlujUkc5UJJ8aquZiBQnf83DeXQQ7Cd8Fx38bII=;
        b=hFrg47bn3oGSaJ8TYTi7uFYP/TLLKVuEJD9wlrnmatFoEpq66zXTXHMy31OkBU8Nz3
         CkS+80t+iBMsXee3jg+xAyaix7dwDiczlWc8GvrLSBegL7UnPYEDq2WNvNaBWcA+PgOe
         3Vh5cgke8csovGL4d3wG1/dgxywxJhNy+l2kCiZMHJis6FMEYW6mK1nBddAMt5ST6pkl
         nOXbMau0aKgrWNvdOP1HFOu0SGdo8q2n2OH56EqrYDBn/aD5attPtjK0AkL1vuo+YPOB
         Gs1NN5urCK9MD2n+iOwlsbWv/7CFS2Kh/eN9cRmR9negd8fe0hTKV8es9kQa9PkVTAd1
         jQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751906316; x=1752511116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3amwlujUkc5UJJ8aquZiBQnf83DeXQQ7Cd8Fx38bII=;
        b=uIrAkmTRf86SJsG0IvGH+eGG4YwSPWgoiXYTmeZX0ZgwB9RH+SH5BKToe5G3LK4znq
         0WnMbh3THDv5gaw1GW/1xsBJ3yFcCw9zpv2Ra0OGF4mXqVnfQolxJoqn3wMmXBkINAWf
         nSaDpOUBB/MjBPeHa9XZthV4h/vnbadQfNOzGJXZxggboQRwaacocoiq2odePc1CtzQu
         RmWCkFmXZuAZgON0U3u2RzysiKbQzoNEF9dC7IdTKzccaXAGqEntQH1OJPghYJEX/kue
         f7aOZrvBTTa9yY1kgFz9Do0PcYKnm9IZp29st9MRq+1fvnp8Pj0V02bxTwr1jWKIAvIh
         MtCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcx5Edgu1nGRChYak4vw6n/yJQSBN4O+8uahvjbcuJmqk5Ferp5VlYtuwS7s6JYDPcDHRQcdrylA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpK35KiyJufpFByh9bNDg9IdnRXyZla8wTtB1P/bAAxApx2Dpy
	SQE/8ft8s/dLUBoWyKc81kd6B+K/SNy2Q2ZdGqLgEbRMw5qPp/XwL1nBVNcmDtKW7fU=
X-Gm-Gg: ASbGncvVvRscNmYxy0tOjMvsBxSQy4aVOtJCBWrSeyfHSnEK3wAGGeO5zUZlGD0+O2k
	mDeLr6f2yhzk0UqLHj0L/zH8PdCMLyhwbLuOvMEIDOluf7xvrLYrjDm5XBRa63u9PRlpmw5AB9r
	wMfl7zOcp0FjkeJsxFhuwZ1FK7o5sB0rdTfFZ+hw7C9P4gajoNbmZ7qzcGvCUb8oEQ1WRCPgPtx
	PRAsu4rU78Dc4khqrqlGet1thVc4N8cztMbVKO3zh1EHMz84os7/VBjEoZ0BIqhg0uVpQo3mBoc
	8DH4WuaEVl1qSAa6hHkozKRPL6ejK1wI50fDeQ0yBCd2C0ug9usgUyUtCLs+pKtV
X-Google-Smtp-Source: AGHT+IEcytjspScMaqVQ9Um6yyQbzDnCUR35ZFequhb17ooZKv5F3UDEUBaebbJ6Kjo7xHpVLJe9MA==
X-Received: by 2002:a05:600c:530c:b0:450:d367:c385 with SMTP id 5b1f17b1804b1-454cccb93afmr3367165e9.16.1751906315548;
        Mon, 07 Jul 2025 09:38:35 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a997ae2esm145978095e9.9.2025.07.07.09.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 09:38:35 -0700 (PDT)
Date: Mon, 7 Jul 2025 18:38:33 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: peterz@infradead.org, rafael@kernel.org, pavel@kernel.org, 
	timvp@google.com, tj@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lujialin4@huawei.com, chenridong@huawei.com
Subject: Re: [PATCH next] sched,freezer: prevent tasks from escaping being
 frozen
Message-ID: <3omgn6ualvnncessgeuc27nmrqmn7ufjvuqfy7v3ppc6irp5xg@unvxbtff3qor>
References: <20250703133427.3301899-1-chenridong@huaweicloud.com>
 <n23vsu6y6cjf2vwdbfcjl2mj7venvpzpblncoa7adn3q5r4lph@qsfa3deqtamc>
 <f4c4f465-72b9-4682-99e6-c249ecab8572@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pedi25sm2ripaoax"
Content-Disposition: inline
In-Reply-To: <f4c4f465-72b9-4682-99e6-c249ecab8572@huaweicloud.com>


--pedi25sm2ripaoax
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH next] sched,freezer: prevent tasks from escaping being
 frozen
MIME-Version: 1.0

On Fri, Jul 04, 2025 at 11:02:52AM +0800, Chen Ridong <chenridong@huaweicloud.com> wrote:
> Regarding your question: Did you mean that the task was frozen, received
> another signal to wake up, but should have remained frozen instead of
> entering the running state?

My response was a knee-jerk after seeing the move inside the loop.
Since the task is in __refrigerator(), it would've been already frozen,
so the 2nd (and more) checks should be OK and it wouldn't escape
freezing despite the concurrent reader.

A task in __refrigerator() shouldn't be woken up by a signal, no? So
your original conservative fix might have been sufficient afterall.
(A conservative fix is what I'd strive for here, given it's the legacy
cgroup freezer.)

Thanks,
Michal

--pedi25sm2ripaoax
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaGv4BwAKCRB+PQLnlNv4
CN48AP9CGbMaWlet0JJRWDJPP8tZt7TWUthxoNxXutxy8cUFdgD/Rtja2l4GZrb/
19ugZNDMwDQO+gArFD3bC+aIChoBogg=
=5Duw
-----END PGP SIGNATURE-----

--pedi25sm2ripaoax--

