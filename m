Return-Path: <linux-pm+bounces-22165-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E1FA373C1
	for <lists+linux-pm@lfdr.de>; Sun, 16 Feb 2025 11:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26B91188953B
	for <lists+linux-pm@lfdr.de>; Sun, 16 Feb 2025 10:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674EB15DBB3;
	Sun, 16 Feb 2025 10:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=online.de header.i=captainfineweather@online.de header.b="hveWaBK2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D875B1487C8
	for <linux-pm@vger.kernel.org>; Sun, 16 Feb 2025 10:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739701022; cv=none; b=ip62C4M6P2JGf/M3iN3LQc8+Trky4VSNzlg27VnMj6O9trllMMXXQDx2/5ymGpEXAP/cZ5SBkw9xm/uxoB82a3MrN7WOw3bXwr+9YiMOoYZ+4bwLlIR04nsSvuqeQ4YP3hybO5S2zd39/MOwWW7Z06N5aHF3BW1f4CfpDc4a50Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739701022; c=relaxed/simple;
	bh=lDyrgP1tKRrqkKBwB2pqMCM1jdU2kKO0LrYsVtLjBFE=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=pKFi8AyNIqf4h39zckTh7EOFysxaPajnfA67UqSEmwzjf1MysY2jkG/iEOr0ZnhjgEVI5DAsGXjDwaIS2LlWDcfg+11mznVfwHpMLVkeDy4/iWNiJg6DtX/4B9MlQMb7o9WbVv4djcgL3WXC4vK+3PscRDL7DleTdZ1ae6TJiGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.de; spf=pass smtp.mailfrom=online.de; dkim=pass (2048-bit key) header.d=online.de header.i=captainfineweather@online.de header.b=hveWaBK2; arc=none smtp.client-ip=212.227.126.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=online.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=online.de;
	s=s42582890; t=1739701018; x=1740305818;
	i=captainfineweather@online.de;
	bh=lDyrgP1tKRrqkKBwB2pqMCM1jdU2kKO0LrYsVtLjBFE=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:Reply-To:To:Date:
	 Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hveWaBK2JJbUBBM/nLOogYBwqpGHqBv+u7KOBsn8YBpQgtxsG/WejxFbAiVUy7JA
	 OlgseC0NjNzt1RwXgKpS7OR/u/OZeBwYNPul/M3X0uJv1Vdtu7z0mn9zmNrI/Z4ZY
	 JGq5IuQCwZ/kOzjQY4lrSW8mTHByqrD7+iwWiWcAe4bM7wN+motNSyfCMcJ7gmZWT
	 4FtnAe6ILCzifTSKnUcbJMOWt3AEMctQ8fNc7JeAFDdke9h5OTFZXL+/D1rzr2uWw
	 /CqpUaxtxXa1RCghs9nUJsVQnz+4wksjyzjY+NOUAfh/RJAXkAjftiqT9gszw6kOT
	 C3DIryvqJ/jxmw0TvQ==
X-UI-Sender-Class: 6003b46c-3fee-4677-9b8b-2b628d989298
Received: from Captain.fritz.box ([79.235.164.134]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MSKq0-1tudg12ObY-00QTz6 for <linux-pm@vger.kernel.org>; Sun, 16 Feb 2025
 10:34:41 +0100
Message-ID: <e6f7d4b028513b1b1d82b859c4747f4f82d91f40.camel@online.de>
Subject: SOLVED: Trouble with cpufreq-set
From: Frank Fricke <captainfineweather@online.de>
Reply-To: captainfineweather@online.de
To: linux-pm@vger.kernel.org
Date: Sun, 16 Feb 2025 10:34:33 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1+deb11u2 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R6RdVbmgmYpTGhLFnVBfzbgcdeD7qQ87XwOD3Q0bKhphUqtkzbK
 nALPC3LET3xCIyTMGTBNdyKHvFPQtsPd/Ugetb6cR1m+pu41o3pIlM/bXzVsRXOVpLDvUih
 V94kkrrZbriIRTJkCii8u/JNkjaukWmWLIuTZzH+YFMAObFRq/uWhfqP3Xt2Im7HUNHi8Ma
 t8PUPl+KSWUzcfgSp+xvg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RS/nhVj+3T8=;EpzfxmtEfCXox/QusQiC/id7lNk
 +F12J9Dhr7VwFQ9dStz24MeW/vNQlbkcYLOndz8p5GoSzDGXiyZjy3hEm5gjEaMFxiriKW3co
 PkL5Im9VPdwdTnJjZPWzz8ZqARazNg4/1aVIb9xjMWM2AqZ+L6l19w1UgkxzfBPDs6yvBBLlr
 vspQ2lTOq0CC8tGEWy+Ystr/8tib/rCsLq7s+HNM/dmVlB1Vlni16syFmC8FN/H+eVuLUV/aZ
 Lcu24EfqqqfHiGEwfpKtTU5ASso36WuRxu6lBr/jgxIMrjh5yir8MT/jfnDRESV0Er/tveCwB
 zjDcDS/Q8jmuYS09QROx/Zl4PKWLL+YYGgcnQIkR2Of9G62OvFg9KKfHa9Dtk4sEV87+DT3hc
 6KD6ihrEXB7NSPHNp6hNHdpmE/I+h/AVMYIqwdJJdjg3LiodZiSkYXL3CzvlNkxaiP4DUQ5pI
 3D3w4lTYtCRgmM60hVhX+IRVJ7qGp21sV/BAo4a4lJrTit4d3HMDTGeB7ZnFbUppvNnBSKdSO
 yWqETxy8gfePwjFqTu0CDc+VHuxzqyopkJT5dTFKjZiJBmooCSFlgMUaezthPGvfkYTKT5QKA
 LQqzxb+zyR1GnzHotMgGFcVS9/po3yoYRn0sFNYR8lDqOeBv6ibJ/wb6u3ySG9LiHP/DgOZsq
 L6g6VBP5dYpLdJTl5UY2C6G/XxGz0Mjk0ALxyp5faCYuB5bE2tHwylkKz9i6H0x5qoGHWAfK5
 Y+CvohVPiWsUgELgvfEgyrFV5FJVDY7cal3fpT9Hl53pJouVMmP5sackI2015WFzoM1gXvNOK
 2IT21p45GIF4n1JU4mKuFAd8iIhrTSp3cL8RpYnXmZyde71yCBJF7LzuadRZhPQu/nMAKpiEG
 c/r/U2cl5bjFuPQFUBXGnLcDwv9Qdnole8KAsXFv0VziOtfSCvbutcT199SsD0ybO0X3bupCO
 a/UdWZ0+Ar9hYN/87/so6APEZ/mOKlpou/d9Q2pfrIgPD+IyLJerbIgSrqx5W6wKIuayFFmJW
 W1PUtpJI3ZXO2AKuZtnNyNc1mWcaHEbKgN6NN3LsK0SXz0aUC2UfmF0ZrIElSTV4A3eapgx4p
 7unxTtbPKSXHfGaiqvR5Txfl4EUhcrC+6gwHd8hACzBUJ/84BsMNrq7inKfbGLp9rBRWFn7uj
 Gh+gv5WHNlEvrxYC3ADNkLZq8eIl47nQw+E376aS0A6e6o77iDBTYxs1WqBjIvzQEXloDhPEI
 AWjR11BTE6UcTuZYOqeqXZ4DMvE+tATdALeBVGAGm7spWzYjYeEdd8WHGxOGWws/QXkEncYYQ
 c2Bsdi0fqT7HSrI76fY80bhf2jZCAKePKds/zHKtaZBRNQqCx6Pr9p9HNwOZWWCkXRK


Good Morning!

Please regard my request to help me with setting the "Performance"
governor for ALL CPUs using cpufreq-set. I have found what I was
looking for by asking the search engine the right question.

Again, have a nice day and All The Best!

Frank Fricke


Composed with Evolution mailclient on Debian GNU/Linux


