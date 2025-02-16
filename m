Return-Path: <linux-pm+bounces-22164-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BF5A37369
	for <lists+linux-pm@lfdr.de>; Sun, 16 Feb 2025 10:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9216716C062
	for <lists+linux-pm@lfdr.de>; Sun, 16 Feb 2025 09:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EA818C907;
	Sun, 16 Feb 2025 09:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=online.de header.i=captainfineweather@online.de header.b="KLz3zYtS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFFA18BC3F
	for <linux-pm@vger.kernel.org>; Sun, 16 Feb 2025 09:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739698772; cv=none; b=JXm95of6fcNUfUkKWqQc50jP4LKhQl5qngt+RtUm23BQeaHBTl+EXqSjvQyLOjf1hAswlIkNpPZrCgH8+PSvdNHmq8ezydXR8YFF5/vYr0uz0kJpZXro34inhUBYAKsPnhzggp6zYG0IMnTCgUV3NxRPZ8YJHUiwoLnHzgoFYGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739698772; c=relaxed/simple;
	bh=7QZD3W+LXX44enkhwLbi8buZ08h4AM8ZnO2DjyTecIY=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=eSLVQNDWGDdpWlzln39sN5BsgI9Bbp3wIYnRMiKJuy2rfrt4Wq2uHEUGOBSvPKFOIm39oBpaBwR0joNlvR3hIrqaWL6uKfeWp65/EBe/mngHDtM+m6uZWpA03WqBmrDnNzSvXskRr5X9xmuL95kxSa5G6eLT79+TYYpR40BRTHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.de; spf=pass smtp.mailfrom=online.de; dkim=pass (2048-bit key) header.d=online.de header.i=captainfineweather@online.de header.b=KLz3zYtS; arc=none smtp.client-ip=212.227.126.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=online.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=online.de;
	s=s42582890; t=1739698761; x=1740303561;
	i=captainfineweather@online.de;
	bh=7QZD3W+LXX44enkhwLbi8buZ08h4AM8ZnO2DjyTecIY=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:Reply-To:To:Date:
	 Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KLz3zYtSY3Sfx+1fgAhL8qfPWhnrPNLc0PdFpXCfOWJKesUPj2mUzruXgg3L+M2C
	 TdkoX5kBBhuEC4HWzcXW0vEiTtqBO22J37T0Hw3ws3VhNJCAVH8MRPIu5QL97DQvR
	 5BJk5I7IiprbJdebGkiGKIMjfA7xIamIbqbojaCap/OEjUNA1atItcz1bR4YJdCcL
	 zt1/aFSfMhVNqeFhaQwSUKWDsftZBJjatEvSLLDRBxTKhofVVvxI2FqthHrmFTjsG
	 B6uf+lmcZDA7PiAk5nO6sgM9JJ1e6NEODh7FtSy4yLwjRD8bdZMu//9WUJUQMoBT+
	 OD4rlLjzehqQ/6zfRg==
X-UI-Sender-Class: 6003b46c-3fee-4677-9b8b-2b628d989298
Received: from Captain.fritz.box ([79.235.164.134]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N7iT4-1tFEB12KqQ-00yUFT for <linux-pm@vger.kernel.org>; Sun, 16 Feb 2025
 10:39:21 +0100
Message-ID: <5b02fa6ec50bcc86761b83f8ba27504b322461d9.camel@online.de>
Subject: Once More: SOLVED: Trouble with cpufreq-set
From: Frank Fricke <captainfineweather@online.de>
Reply-To: captainfineweather@online.de
To: linux-pm@vger.kernel.org
Date: Sun, 16 Feb 2025 10:39:21 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1+deb11u2 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:38hcvTyJ+biS1uEPNgGBSurmBwmkwJyXbLxNV9RHWX72+la7J2i
 f32fmidBLcmfY2fIu5bLMsgf1uglFsSVmvBkUvqmBE0QJr3MWtaA2jsTsmgbQqIlSMG1Vne
 592ZBLXLBbmJRNgvU44zZKz9bcrA0zwy8TvDq9lgofrj3htIqEmtzXS7ArKVi+7FvjMHCEc
 T0FpIzvsJk7j8yQc0c8nQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:a8QKuJBtqMw=;rENoDhxLNYMnc74rfj2r56DDEdJ
 rRkKoHyJsHi6fMMB0yt1Fa42JRctZt/gtbCxjVmEzWzcQiizlP6WBXCVGD9LO/Sa2XLlCa/0w
 KY4vKs7S3YLSDCUPNhlUM1Z2pPyTl4a6kKlXQAjLipnSY4mTR+PhONJ+tcV2edbQyVNAcDTsg
 iFmbY1g77CcktYcTjKzgF9cAl32+jOX71OzIdc5WaMhu0uJ6YFHhR7i/W9KYAocenT32qy6fH
 1QAhWaG9tiHKohjlrLo2XgQmmKWCPjwEv1/BiDbmEkL/tB7Vz9mOonxmMGTWDp1RbJ69n4FfR
 PUGV19IyKH/1T53GROylmCu47XaaTmKK3n571U+WjqP7tUSQMbvT9cg+AW5f5gIjdKEY6vhai
 OqgIJNpm3HK+ybsUTFBb5hr0m350DxUelv38NgxHR6Dtv6D+KcDYGdwF6XjFSScK0AuCYW8uc
 /bRwdeY11ojV2jCPH2JFyfkyU3QqGuNUTqqlTug2bZhwux4aC9nuWf00Kje4glwsg4wMJHNYs
 bQzG7C6UI5E/180Qv5amodYMioo4ZYxULZro4el55cW863uDzOxdI1m78qEBdiIqTyjaUx/OJ
 vFlafTTczmxW8lSF8O+fF95avYB9lAAcN+SxSUh5ax2uE0tWrT+1ytrz3lffpsrivRgmnnHuq
 E5qW5TJxyVsb8hubUwL3JFmQK3Bxz32IXPTS+J7qdGXKeVOeUHOxJ2drLULlkOjVYeYJzmrar
 hWulRzxk2QOmeeTLHCNkl0ERTWLaoyWwwPSYd49d8oK6BGXNOQRfK8WnR0PYpvCfx9ZA0FM0J
 umH4d/Rk1Oksx298Q/bxR2TpcBlydagBQSIZNojdhwIlB2QaX3IMy0qKbJtE326wXODwsIpOa
 fHTf/iQJ6eorG52cYbGldl9KaWp8RT2t93OiVy2Amyq/SEkvtp/lRtQJ64IoeeUoz+8PV53ZT
 XxnTUpi/TubL4siWnUibqjG2qoVQooywt4QKZ0eh/c1ReupCnrviTww/1nQCORdN/ehbUKKfd
 Y6DSqbqV16cg10UoJ3arRiackVuTGSKNAhdVacT1Y5fM8/wIxCgIuPrnKVWJW7kEPO4nJcX3x
 FvZPDa3an/NlA8nLW2KF2K5KJbSM5VilQhboQyhmP8sURF5+wXLDKgVEZh5sThKhspMZIqqBr
 qixu7SPQoXLjZQ937hxfZ4iUeHH6Re7w0qfF5ABqYunmPVVbF+f5DW+mo46RBF/6D4wI02/lc
 w/v186ppfx2RT2E4Nd71Zob2AfoYidxNSOt/47m9q9wVkVWAlWcM7YhtQF+GG1ewwhxdyibwC
 hT5WuykFl8PtIOJr4nU9fXu4bgWokv6/jLQv+3BI+ZWHSbgI59mcRQvNHVipn0qp9At


I forgot the words "as irrelevant" at the end of this sentence:

Please regard my request to help me with setting the "Performance"
governor for ALL CPUs using cpufreq-set.

Now it makes sense, doesn't it.

Cheers,
Frank Fricke


Composed with Evolution mailclient on Debian GNU/Linux




