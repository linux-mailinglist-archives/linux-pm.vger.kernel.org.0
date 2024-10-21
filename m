Return-Path: <linux-pm+bounces-16081-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4499A66D5
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 13:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 109CD1C21BCA
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 11:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DFA1E633C;
	Mon, 21 Oct 2024 11:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="EU0TNQbB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77AC194C62;
	Mon, 21 Oct 2024 11:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729510874; cv=none; b=PtEjUytI6CjgbUnoq8/sehPoD6G7Sp9evtZN4Xqv4fLmuFCoBq6GMuPKOfx3q8/WyzD8395LZZA1GHQGrWY1AQ6mH907awtfdc6721hU7IFgo5zjSX1GCuqatzCCcY/SbfqlKC2wN4I5bmZrbxikBOvTJ8wAs5mrda7QaSjGszY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729510874; c=relaxed/simple;
	bh=R0xorB1e9mKhmyRnjbcDDMubM6bcYjdc/rBs21AnDW8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=s3DJxivCZ95SaOCI1eG0Kzo+/jqIb2N7x/axcm2pdngqbeBxsAt3CTsU3ZC6CvuWe0Q8mAw9hQfT6baDNKWqeR0TkAqV1F2wL9s57CsE8mRJz8STGB3/cY8hESWE1P8x5qelnB432Az6Ix/oHpKG/UE4SrGoIvfdSH+vmgOuU98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=EU0TNQbB; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1729510854; x=1730115654; i=markus.elfring@web.de;
	bh=/lRLW8ap2Wm0zW8hgGg/4R/M0O7S3PiGhenSmqjOPns=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EU0TNQbBUnybSPJ3KO+XHkbZcugpGhCN8i7JS+p8mrylCa0UK8TejXITDXq5mp8a
	 XjYd546w0vxd9NJPRAucNlOS9/UWlMV5IChmJ15OpdXfmyQalqzL4eLfcO/OF7kYJ
	 z0cYz6WnfIfmHm8DNS5tmXEH8xXTzN91fq70v9oDfgmPee4t4CA8FPWiAs2bivTQe
	 FkQsWXVxdHuQ5/sda8Sh+1I6yYSI8tLBxxjUNH0IgNYNCsMPZSyx7jp+HyHWrZJyZ
	 rjWsyPk0tGp8miUIJgF9aNkX1IluemcdKNH0rgjN/f6HteyF06NqEbVwLvmjLZxnn
	 h3jH/h4iHKrC2vtHoQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MmQcf-1tlDxH36Zd-00iTdj; Mon, 21
 Oct 2024 13:40:54 +0200
Message-ID: <40ec7bb0-02ef-4af7-8934-9f960fa15355@web.de>
Date: Mon, 21 Oct 2024 13:40:52 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba
 <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
References: <1930069.tdWV9SEqCh@rjwysocki.net>
Subject: Re: [PATCH v2 01/11] thermal: core: Add and use thermal zone guard
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <1930069.tdWV9SEqCh@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rqJR5/feJtptTrh/H7G+ovBHdboQlHmiSnHnHftjtygf8LkLOPt
 BhvKlU71R5HPhGqaZ7PvrH1WGmA1MbQCDlrPFr2uVeuVYD66LJl+RdPKoIdgAlniHT8HkQk
 NNM1RoPXlqlRJGsP7MmNp+GxYnZS81ImQWmGGHY4lVF1bkOvgD+DjIRjguKljnwRfBc4YqU
 9FyKbu5T0gZvQWBKMhhJg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:We7SIprs/cA=;mA5Elh9IwRp7PzAPtWRHjtzkTlZ
 mFs84QNO26VFPX6dI+05/byhYpaNtsOjssiWhDJfqSJE1n08vzryhCGDuPJDPwXZJouIyVDJk
 AmIoOTjEoWcuu+koonsDfAeBoGX1J6rTSO8DEJ+4WQmLgKcwB5mFW8gKG9qo6wZ14JBcKL984
 /7Pxe2NPx2r587SS+G4O3z9fncwNDpzQnrOvCHXrhzo+YywfUs2O2CmUK7Nq6G5P7z+1czGbu
 3hF1e0PZ5G1P5uxi5vcDrn2L+pjAVO+vJ5NJ8jv9evWHUZ73NjfglNSegJ09rqBBV31WKC6jV
 zs4lQ0w1gdbmzp5LJNbSWtRP+HaCRX7IQHjby676xk08ZOxbplX3fqhrJ1QPSjkRkDw4cwJD0
 g4/2FPH74RVdRYVqtg1RWcsdiFBhhHRVIO3r6rwb1qegGAiOIO//53cBwp2ae9hn3b5W3RpNH
 iOBlTpwZxrk7j1iiYum7tJPfNc1qBZDso3qf5pnV3LM/Ermu/zvIyBAgoJM4eoghM1Aji0tAp
 2181EqwLbq9wM4EUbhfSk7YekVwrHevqK4PD5ZbmdwY1fPrC0uys/TuY/5HrNqaXOQToixewF
 jg/wPdXb1QCTs7vOcrvpX4nawZJp4EEpvFYpe1OGWRuI8K4sn9KWbyH2UUo8KvcRSQsPhF7s0
 J6peZNvpT5dT89AkyGHKBHiuIVjNRK/avlfFBa1ZTZ6JlqHp0HSwG7+cPZQx1ofOYMVEZYImi
 JzlgZnobod8Ez98AfNoiYoGIcQ1U3xE2PulJSyurR+0omoAWX6cWP1zTWdmwIx5dlDraCpWRE
 z161ObMNKU+kq7Q/W/4RGyAA==

=E2=80=A6
> +++ linux-pm/drivers/thermal/thermal_helpers.c
> @@ -60,13 +60,13 @@ bool thermal_trip_is_bound_to_cdev(struc
>  {
>  	bool ret;
>
> -	mutex_lock(&tz->lock);
> +	guard(thermal_zone)(tz);
> +
>  	mutex_lock(&cdev->lock);
>
>  	ret =3D thermal_instance_present(tz, cdev, trip);
>
>  	mutex_unlock(&cdev->lock);
> -	mutex_unlock(&tz->lock);
>
>  	return ret;
>  }
=E2=80=A6

Would you become interested to apply a statement
like =E2=80=9Cguard(mutex)(&cdev->lock);=E2=80=9D?

Regards,
Markus

