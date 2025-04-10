Return-Path: <linux-pm+bounces-25184-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B30A84E4A
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 22:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0432B9A5B7D
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 20:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7C21FAC4A;
	Thu, 10 Apr 2025 20:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nFQWXqyC"
X-Original-To: linux-pm@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C352259C
	for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 20:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744317569; cv=none; b=FYfINgYd2arC2GdaoTua/UoIGemlxqEM+4IxtVXfaJs6frJRS8c0bTVky1UuuOekKo7Ya4P1yAzqwB7WuPGZsp1+L5EHrN6kNdA59pZ1lIryRGq3y1yhzJz64GHf3cSrkuD66oply0w8r45qmbmZ70cwZQRNWlkx8DWxOkQMLms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744317569; c=relaxed/simple;
	bh=6jiEsG4tzwBrkkukwz+ui4SmAdOx/hmaKaCJ1Z7FKGw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=pGHun4twUpIYaNrAUwdr08GF1ZjyVCkMOJ87CAwjHI2uAPQn8/6hHWYmCV38ytbQjzBHNhV0tlImJscTSEYdoYTCBHSYMVZq9HGQZ6/ZpS6ngzvpB4zHryc6Am9vkyMse5hKkgPUDMOj0SGR8+vw1/QdPoyTQgQ6nrJQ/NJtBpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nFQWXqyC; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Subject:From:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=+vfzgKdtZZlEJJEB7dOeMycMF2tp2mm8G5Ok7MV01i8=; b=nFQWXqyCzAp21aMZLrJ/CGWGli
	7wtM0svveoT7KUp9MwcK+ZTnOKGxoCdhkFzsp4Cv8WRiefQDBc2KJb4/HmRNO47e5nMiYPfp3HXwV
	5eCg6mZkdkgbxALufn3ccdebiWeGRD6xYMm4q1Z92CxbUnIhSxmgQ4oFXqSGA3RdfYKkQo6ymuBUN
	mQ0LZerGA1kMGKnt2OgPdfDhA50P4AFVLrcPbJy7/1f737jRJqM8ECSHXqLdinpwNMkZYP+q7wpGE
	UGekvsF3y6E1cmv1Knd40M96TZcPee0lILgue2OF0xiD5KW/VM/N7UISc6Ak4KtIxr7xw6Smf5lqs
	dfjKiemA==;
Received: from [50.39.124.201] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u2ygG-00000008s43-0Lg4;
	Thu, 10 Apr 2025 20:39:25 +0000
Message-ID: <51d02a58-433b-470f-86ee-618994cecb22@infradead.org>
Date: Thu, 10 Apr 2025 13:39:21 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
From: Randy Dunlap <rdunlap@infradead.org>
Subject: cpufreq governors
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Rafael,

My little (Intel) laptop needs some performance improvement (IMO) so I set out
to read Documentation/admin-guide/pm/cpufreq.rst. I still have some
questions that I hope you can give me some insights into.


1. Can I use the schedutil policy governor even though the P-state governor
seems to be the default?

2. Or should I just continue to use the P-state governor? Is it preferred?
If so, why?

3. Can a cpufreq policy governor be changed by whether a laptop is running
on battery power or A/C power?


Thanks for your help.
-- 
~Randy


