Return-Path: <linux-pm+bounces-36107-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EC4BDC5E6
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 05:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D26741894B1C
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 03:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CDC2DAFC3;
	Wed, 15 Oct 2025 03:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="A8zFAaLO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E942BE632
	for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 03:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760499682; cv=none; b=Utw3m/J2Fck9OOaMEdwzbUxCVcsoAHYSHln/yRUHYC6/yFeaxsyGYnW7YXpfvz3jjbczf/dADb5hLVCuNYrfG3YpWhoDqrR51qPDO3mp7sR627CujMhqVaPGDM+LPXrsTYPuT1jkNcCtTNxFCwnnHlzVjbWy7GgXk54tY8/K+n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760499682; c=relaxed/simple;
	bh=UvVy+BajAErhJO3H45dp4i8wuvTsyXthdxxIvUFbFIQ=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=n5RlxNke2yLBifgsvFQGezCmptHqT9bp+eNwWX9Dix05OTLpsKKXIqg4nSy1hZMy6Xl783SKqZnPpjvMMXkxOAPCcOthQ3EZSSHZsKKdDf+POAEPfNyW2GoLPt6nJyq+hzP/AtRAC8twz/Vn0JK5jJWqCuU2uB+LZPs7CiFn+rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=A8zFAaLO; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b6329b6e3b0so360437a12.1
        for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 20:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1760499680; x=1761104480; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UvVy+BajAErhJO3H45dp4i8wuvTsyXthdxxIvUFbFIQ=;
        b=A8zFAaLO3xA5vgRwjswM9GqrH+/mv9UBu/ShRcEbb/6vOM/axkHavN4sfFCpY6DQvJ
         CTUgAcvqcZdokCMH35tHo1IUM4KhohLHvNdjBw6lj1wE2Vq9N0r22QBUgyPpWTWixO9+
         i575VEUPJc2S8OS3UyVwWYKbf1O3lpqOYSnywnvEp3dS9scBm7bczcowcIi9dF0JyNcC
         D0yZ/1t75i820RKaItHCVE/2ZE8df1Frm6zLzZFPXZLJgLtxZ8iVmRz5RsDuEOj7QE3q
         0PIiToJcS66EVXOyXdS2jqtq7xgVV3LZowKJXfKmyRZM+LCQRbxPrPOWPg4o9i3CymQx
         RZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760499680; x=1761104480;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UvVy+BajAErhJO3H45dp4i8wuvTsyXthdxxIvUFbFIQ=;
        b=tAqUzzYZuUrxjiATd+aswuqrpMQ3HSnmTH2C5Xo4PQHHky4SWHvQPn9EXd8mHH9uxo
         g+zB5eJbl+vNGDx7tcUGkCyMIpFWAK25QWB5T7DMQoiBbQqUHvyJ71G1ZeaXkJgM10Rf
         lvbF4F5PQ/PHvU8dEJu1+wsXWBJvGzjxl5x/P2Xgc5Yo9J+r2zGLg9b6aU7mXQJorXwu
         64YMa/tSFfihObpVmf32I5/1E8eU2eE2v9OjD/9Jhmyz/p0RkWGQ9RguBy1ibHLxJ2Ss
         vxNrgrfwNH/EfGSjNWFM77p4hDe/lMgRP5jn4RH2xn9B64wCWfv4fl11QlUwFzSvyO3Y
         /Bgw==
X-Forwarded-Encrypted: i=1; AJvYcCWrEcnNVOPM1rnyap0jH89HoBCtFa+WDicrzuQZi2mP7dwnT9nyGqQAwRnBH+czOGt8ZngrR/6VMA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWCYp0v2xMxH4soyXsvA/r4DFZv64vAtZfsensc7YDUZmxnsMz
	ta3kaWWg+F6g8YGxh9Vmb/H1A0aWiYnJZr2cOQ1OHtPvMDz/mqqsTqHlpxBOYhrkscY=
X-Gm-Gg: ASbGncu4u48md5ja/0Ug4CUZNUr506jcmdw202w9WohSi/biYihCavC7bKDL9/vuQEj
	qS2zBi2sjGNv/hAvUFXn82tKYxaH8d+8RTv2KPih6ib7XkRRymVCQAv+rbXufZxiSUurui3+/ae
	ULe0u3n7u1hlM9t4CYUdnMpQoOzl9opC+xw2a3g+21edUKMZZOxlHc2FPrQar0DOXEkspr7c2JB
	LSem25GM8cl/g085BglW4uh13IftrbR7imCxtQix84JvcnO/8rLoW3G3Jozznnr9OJMuEEfKaWC
	dEi/rT4lb+eLKE724NsN+rPDwSoCYPUtAuMDnmepb/FEwEA1o2UPtW5jUmaPwQC5xW77eCHp5bO
	pd1xqskNIw9EIvrclBM3G5WwGfuuBdlcrCg1NECgcaD/+rexKhFJaQFV6M6pE4/qZe5pgp5qEyv
	h2e6R5XQwwPSTCmy4cnk5T5ov4pl0=
X-Google-Smtp-Source: AGHT+IFk5b5m32PEcjH/JKtGeyCG8BkT/fRM0LBEsuJmc9XEjSRySY8y+FS7HN+VgONfFO05J6xNhw==
X-Received: by 2002:a17:902:f691:b0:267:cdc1:83e with SMTP id d9443c01a7336-28ec9c975a0mr435584925ad.15.1760499679467;
        Tue, 14 Oct 2025 20:41:19 -0700 (PDT)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e20f8csm180651275ad.49.2025.10.14.20.41.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Oct 2025 20:41:19 -0700 (PDT)
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Sergey Senozhatsky'" <senozhatsky@chromium.org>,
	"'Rafael J. Wysocki'" <rafael@kernel.org>
Cc: "'Christian Loehle'" <christian.loehle@arm.com>,
	"'Rafael J. Wysocki'" <rafael.j.wysocki@intel.com>,
	"'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
	"'Artem Bityutskiy'" <artem.bityutskiy@linux.intel.com>,
	"'Sasha Levin'" <sashal@kernel.org>,
	"'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
	<linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	"'Tomasz Figa'" <tfiga@chromium.org>,
	<stable@vger.kernel.org>,
	"Doug Smythies" <dsmythies@telus.net>
References: <36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7> <08529809-5ca1-4495-8160-15d8e85ad640@arm.com> <2zreguw4djctgcmvgticnm4dctcuja7yfnp3r6bxaqon3i2pxf@thee3p3qduoq> <8da42386-282e-4f97-af93-4715ae206361@arm.com> <nd64xabhbb53bbqoxsjkfvkmlpn5tkdlu3nb5ofwdhyauko35b@qv6in7biupgi> <49cf14a1-b96f-4413-a17e-599bc1c104cd@arm.com> <CAJZ5v0hGu-JdwR57cwKfB+a98Pv7e3y36X6xCo=PyGdD2hwkhQ@mail.gmail.com> <7ctfmyzpcogc5qug6u3jm2o32vy2ldo3ml5gsoxdm3gyr6l3fc@jo7inkr3otua>
In-Reply-To: <7ctfmyzpcogc5qug6u3jm2o32vy2ldo3ml5gsoxdm3gyr6l3fc@jo7inkr3otua>
Subject: RE: stable: commit "cpuidle: menu: Avoid discarding useful information" causes regressions
Date: Tue, 14 Oct 2025 20:41:20 -0700
Message-ID: <001601dc3d85$933dd540$b9b97fc0$@telus.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQFP8RZJEbA2uDnjQfbsE3QfwpHW3AGSQ1aYA2hH1ScDEHwS7AHjtqkUAUPNRMECUslMCgJdmtwztVwLqSA=

On 2025.10.14 18:30 Sergey Senozhatsky wrote:
> On (25/10/14 17:54), Rafael J. Wysocki wrote:
>> Sergey, can you please run the workload under turbostat on the base
>> 6.1.y and on 6.1.y with the problematic commit reverted and send the
>> turbostat output from both runs (note: turbostat needs to be run as
>> root)?
>
> Please find attached the turbostat logs for both cases.

The turbostat data suggests that power limit throttling is involved.
It also suggests, but I am not sure, that temperature limiting measures might be involved.

We need to know more about the test system involved here.
And we need to separate the variables.
What thermal limiting methods are being used? Is idle injection being used? Or CPU frequency limiting or both.
(I have very limited experience with thermald, and pretty much only use the TCC offset method.)
Power and Thermal throttling is never involved when I test idle governor changes.

If it were me, I would limit the maximum CPU frequency such that power limit throttling did not engage for the test. That would
likely also eliminate the need for any thermal limiting also.
The suggestion is to then repeat the test.

From the discussion on this thread, it makes some sense that the selection of shallower idle states more often might have caused
more throttling leading to the apparent benchmark regression.

... Doug



