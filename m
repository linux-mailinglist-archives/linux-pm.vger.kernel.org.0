Return-Path: <linux-pm+bounces-29796-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6264BAECC63
	for <lists+linux-pm@lfdr.de>; Sun, 29 Jun 2025 14:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7011E3B4EDF
	for <lists+linux-pm@lfdr.de>; Sun, 29 Jun 2025 12:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFFC21D595;
	Sun, 29 Jun 2025 12:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=jvpeetz@web.de header.b="G8m6szAk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD3278F2E;
	Sun, 29 Jun 2025 12:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751199002; cv=none; b=p4Vu7TE8sZLWxJuzOO6prdcCMSw4e7zU/5CtI11aI/aBUO1syN0mSna7+Rr4e+kVScq7mOLR8rMDAfpiovuSLViEEmVmo8NyV2BiYH5CFuFnqx2WnihJ6WT++0C0c3iuKxzbgLcOyQuNYcM2I57nD77IKJKNAbFmOp6BcvEX9XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751199002; c=relaxed/simple;
	bh=MUvfW5Xs0DyKobQLkvwyPzBVzw626yGSX3Q+Ebd0bMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dfhotMz7VojCwSiWn65PjyfKfis85NqKcSVzx83VSw7sRkPw8IoavVB3Xd6ix9Vm9RvSXJZal1FGGT18+1ZOzcMApI/1rrv8ylWGjtVZ2HK8hrWg578I1xV+3qOyE7rtQY8WCzHlqUkl0PoVRNpkyNMGuUJR+5bjswE/5JGrnMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=jvpeetz@web.de header.b=G8m6szAk; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751198992; x=1751803792; i=jvpeetz@web.de;
	bh=MPPN2ZiHbr3G1Q8AdmMbMw7KZutJ68YalC728Q0eInw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=G8m6szAkmA32NeJ063dxGn2+qSiEcb21ayEox0vEGzYgdExHnT2mYCRUUgpPUOKf
	 KzN2znL8XuKP3lyMSreeAtRcSIGXALL0dYvmogJhfJNujuTWPpD8RoGuHJjy1iA/f
	 p/2u1DgD6STnJXFzBWsy14XpRScUENTqrbAkq0BsBTRLNXYW1oI0Vbw8AUWuQWtDS
	 lrb81dKbVPzk7WM3rQwjdfUS3VB2w+XyA9nyMYiZVU/ZgxQVzhoml5s9pb8Y90u76
	 nEl+U99tXJer4pys+xarJ3cvwHaWZtK/7sFCKxCDhdHxPvhmopq3iYGB3Fa++BCAS
	 hyU0hiFhw6roG430hw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from uruz.dynato.kyma ([84.132.145.192]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MgRQD-1vDAQJ0FUV-00ouve; Sun, 29
 Jun 2025 14:09:52 +0200
Received: from [127.0.0.1]
	by uruz.dynato.kyma with esmtp (Exim 4.98.2)
	(envelope-from <jvpeetz@web.de>)
	id 1uVqqz-0000000009F-0gSf;
	Sun, 29 Jun 2025 14:09:49 +0200
Message-ID: <c7b240ad-03d0-460f-be05-0a61e1267695@web.de>
Date: Sun, 29 Jun 2025 14:09:48 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 6.15.4
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, jslaby@suse.cz, rafael@kernel.org, viresh.kumar@linaro.org,
 linux-pm@vger.kernel.org
Newsgroups: gmane.linux.kernel.stable,gmane.linux.kernel
References: <2025062732-negate-landless-3de0@gregkh>
Content-Language: en-US
From: =?UTF-8?Q?J=C3=B6rg-Volker_Peetz?= <jvpeetz@web.de>
In-Reply-To: <2025062732-negate-landless-3de0@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B02UH/cB8YdGY/8RpbIPbvuF21zzGNT06dg3X6EzxsztWkZf2H8
 iCbUxUBel6JirfruZhiTWGf8UzoF+wA+w+1G6LRzws7vXNKl87+XvSR24nZQvzYO7PwS9O8
 4rSLRPgwKdPT8YFHua+4oyPtGzHiqx9fojmiv9dUlut3/k+WfhMxvBkbl/kuGTI1OYFbp7T
 1TYND81l9TtkpEiXXw1rg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Pv0YgODQX6E=;5YRXcR4cs6lbiiknf2Bj1yWJebJ
 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

J=C3=B6rg-Volker Peetz wrote on 29/06/2025 12:22:
 > Hi,
 >
 > upgrading from linux kernel 6.14.9 to 6.15.2 and still with 6.15.4 I no=
ticed
 > that on my system  with cpufreq scaling driver amd-pstate the frequenci=
es
 > scaling_min_freq and scaling_max_freq increased, the min from 400 to 42=
2.334
 > MHz, the max from 4,673 to 4,673.823 MHz. The CPU is an AMD Ryzen 7 570=
0G.

I should add that of course cpuinfo_min_freq and  cpuinfo_max_freq increas=
e in=20
the same way.

 > Has anybody else noticed?
 >
 > Is it intended?
 >
Regards,
J=C3=B6rg


