Return-Path: <linux-pm+bounces-22155-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D53A36F29
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 16:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 497A43A7ED1
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 15:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F601DC9BB;
	Sat, 15 Feb 2025 15:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=online.de header.i=captainfineweather@online.de header.b="LkfxGHhu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE36D84D02
	for <linux-pm@vger.kernel.org>; Sat, 15 Feb 2025 15:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739634214; cv=none; b=SZD+hU/1GG1dmIY5z7TpLbDvaO7etbCXNzZzidxp1m2nzv1T5yi9LUXa+DrhYf2mbMvcw2W2y2JhkxX/CjPPFP9RYSFDUnkH+zekff1zDcQlIO6bb6KZ+jjsOwB7Ej0drIBccjJY7U3jtlOyeKilNGnvinu//HHxNNQXzq+FIi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739634214; c=relaxed/simple;
	bh=T/l6R7c052cpChK/88MI3HKLKlt544tzWGfWRGGvOIo=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=H5JDQ1gfWu62HXm1Jcxy4+Kv1g/wu8F2jApbAbLcN6WdI5ek9VjCaCgN5h2tXw8gPz9rz4kiANQh6VY2/JB6zzoSO2eEQPyGwMiNx7Ud1JUJWytpnP9+6v0YS78FhK8wb10hU3YOOyeQC/Rh7aSy1IQM8pqMf6UG4uLXVq2YtG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.de; spf=pass smtp.mailfrom=online.de; dkim=pass (2048-bit key) header.d=online.de header.i=captainfineweather@online.de header.b=LkfxGHhu; arc=none smtp.client-ip=217.72.192.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=online.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=online.de;
	s=s42582890; t=1739634208; x=1740239008;
	i=captainfineweather@online.de;
	bh=T/l6R7c052cpChK/88MI3HKLKlt544tzWGfWRGGvOIo=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:Reply-To:To:Date:
	 Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LkfxGHhuCI9iVX0lfWGSFECAeCHqJ5UMT+GCUgSY8rPwqlWyd92gfLMOhwQ9NtMJ
	 5kMzniKxSfHml/Fixge8t+hm0r7qxERvPKIv5C/Db3ygUFsrPsj+PdntFhMd3oWxd
	 f3es4yRkHb0ifyAS4jvQKHxNmIMLYTEQRiC4NO48wrQhyVsMk9sa5g8vrRwnOHlYD
	 QEnLcaQE2znUKbFWkkYwDss7ufrSNkLWVOpIiZHhYP9YksHVlrSJu+K7uELcmCLAO
	 jZ83ZQ5r5WqAubryYgE1O9FKbqBY5YkMp4jJa6dx5z26laVtn1M2AsqlfDbg4/Nqi
	 yY+vfihEvRF3t/bVqA==
X-UI-Sender-Class: 6003b46c-3fee-4677-9b8b-2b628d989298
Received: from Captain.fritz.box ([87.146.17.67]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MMnnm-1u25zc4C0q-00KNeB for <linux-pm@vger.kernel.org>; Sat, 15 Feb 2025
 16:30:29 +0100
Message-ID: <48eda7b68480db4209eb9c5a2fef4260180c3a49.camel@online.de>
Subject: Trouble with cpufreq-set
From: Frank Fricke <captainfineweather@online.de>
Reply-To: captainfineweather@online.de
To: linux-pm@vger.kernel.org
Date: Sat, 15 Feb 2025 16:30:22 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1+deb11u2 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:5lv7LXuUCKXXCO6L2OsjyuZWt0lODE2MG5VGTXNuJjUc9l6onve
 L5KyZWyLYbI1gW5HQA9ZNQN5gOn07YN2KBenJ6b5E5QQuJNvm78kO74WL0QNu1i/Ju3XJAt
 CYemvm6gZfOXfMwhsq3QYnsAUKYYfB0YwgVzd7nyOWe2FDCYn7I4RdFXBgzor6Y9XjDNzLt
 +jIBJ5wKoKkYJqOFlwNMQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Q1QZapLnytk=;nB1UuEAIISM+eOFxu1wgW/Snawt
 zXU2Rq8JZbuYyx8nhe+CRvlhEc+7ECyeu/BE/4mInOcW9C7VOnvCY/PEn9wxN2qK1YmGOCB35
 Kg9uIIZkIWkZxWlhK7ouj3Qd4ZFigniQc7k76FCfigZwMayemDOdsPuNPJfaxd/wxXrLFSeKm
 35AGaxAhWVwrvtbFTDebjaKiB4CEfoosyRYjw3cl7MHo8Q63prldX26PBCVSzwKqDV6ku9kbX
 aL9zDHNCF3SCR++/1nvjDEdVJJJUePwl1WhvSQMqdoMlamax6iQX/ebCgM6IFE307ZVLWV2sb
 xojL0MtYTOSfM6JI5hr3cBZdoXHUY2SjxRDAyGVFTKjFyG0prOh8uWpMR+A6OBV0uVQLyzYQ5
 Rj0OFmc2BkfFKhYTyk31SBpFF4KgHEYG8008K3RoInG0aKqp9f4tiJMG3rvqZUiRHjTKSA01A
 N0sTeS8e/8NDDPtkoJueYE92zMgGlIJeIHbEVNlbqCRyMC0r4quBTBSUl8/SExqGj0KPWI7ee
 UQDUxQ7yuexRiWXslriViP94c9PeKJF+GxCSbudM3fDiWwicDgq5V86kk1ICYYIisGKROuRgz
 HlFbDLwMSpj49Dv0AUuxVtoLLvPPBi2GRc4yjE773dqmFzpd2WE/jNLuVRjoiknAdRCcCVpQm
 Ht1DI33H/IB0gIWGh53PQ1C61bnClRpsNUD85l+MTkNLLDkIcpGABbCw1t85hVHwBk3HJV34e
 bSLc/GeqjC3viHmGhrRymMzv2BDCjDtcUxDtS1/8UfpKbXyykns2C8jGCbHe2JRLKvU6CJPuT
 rkLcY/Kv3eQeQS2xQFt12L9haWMl+sQz6qL1xivgQKQo526htpSYSorIt+xzeaIC+qr2e05zV
 8wqxIoaDOH9YN09k1mCD5s6yGJjkf8o4mQA9TSdSlhMCki82tb1IIMhbyhcqrju/6bgCgtHkY
 QIsA8rgy6YXqEfcnYiIC+Cqos/6X9uwukY+f2J3WYN0cAstjRmy4mo1+rPjsbGvBlFqdcXDnF
 edN6mv6Iq979IQpoajSKB6VCCUxs+UDT95iEWtuIzPmke25++RNIu8MVDhfTlx+LNgpZYIkjn
 BqekfKioqOW6Tgq7142v/92Lj+D7F3NuQqmalmj6BKMpVL00s/oAzvmHsOpkaaoNMqlcTnDYY
 Vh2hp87P8PKhHdWnemhpKnFTi1/1LO/YlHc5y0v10HsYb3y04ezAj4lzcUHWjOS/KMYMAW4+0
 BHzrYHtX/xoHm1zm0P/UQXq3zlT7BdjRRaXEIgy5y9pRZ3TdRCJNHkAr8Y0+bZ57xujNQSJyo
 0pRTVbXxDLi2nfs/CycJvmtSoRASVtcaUptebD+8P1HZxXb10W4NgC6gg7RPtRa3FRn


Good afternoon!

I want to set the "Performance" governor with cpufreq-set for my dual
core CPU but I am having a hard time figuring out the correct syntax
for using the -c option (in order to make it work for both CPUs) since
the man page is not quite specific about that and I'm not very familiar
with that sort of thing.

I'm using Debian 11 LTS.

Would you please be so kind and advise me? Thank you very much.

Have a nice day and All The Best!

Frank Fricke


Composed with Evolution mailclient on Debian GNU/Linux







