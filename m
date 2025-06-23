Return-Path: <linux-pm+bounces-29328-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31983AE415B
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 14:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EADB3A9260
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 12:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F65425394A;
	Mon, 23 Jun 2025 12:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="om0TrK79"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F2D24BD02;
	Mon, 23 Jun 2025 12:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750683366; cv=none; b=ZREjtjENfuB/m1goHI4w9XRzPkQvNI2xBwkaggZkUqgnQXMbEpqVOzOEaagReiJfZszFBWzz5SJ98HxnN9W/xlGFKuz0XJPbzOxmwNhkD0f9AYRRNPHHXT0qw+wO3Ghls1YZ+vDNkQ4wW88D8zPvRhnrkYfr7Y5ocSKIXjTwaC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750683366; c=relaxed/simple;
	bh=aKqzR660yAGjlQxlkDw+qNq0du0z+ZkUKklGbL8VbCs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G8jhoxAJZ0yElSDgSLw3XIe2QyQI1hQNKHoATSjeqbgPFs40kOesA5YHMrc21/0wShZrqdyukp38luShLT/DRaSEpqu2Awbov34ZMmt1Rpvr6IGkGuNj3OgcsBoNOKVmlm6yX/ivk14AHmIMpVnggVlNzOe7WJh1vcC79DyAIrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=om0TrK79; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 209AE66DEE5;
	Mon, 23 Jun 2025 14:55:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1750683352;
	bh=aKqzR660yAGjlQxlkDw+qNq0du0z+ZkUKklGbL8VbCs=;
	h=From:Subject:Date;
	b=om0TrK79Gj6e9fxm+piGMrWeEaxHgC8jfJ+e6oUUy7tfSuw9eA5bQl3/9m6mAzw/N
	 LFLt2fb+INhBD4pC8ozow6Y9V+nc+h8v1TBVt2kYjbLqgWNjMb5BgNh6qFa9RQF3KP
	 qQ4DQva5xUIkMSprnNdPW9JGC1a9FNWJIUJh+N1WU8JpVDOycvfYTXf0gYJVbVQzKb
	 a1v7xVM+igf5vbD5j2348TqlNeSLMBNpwsxEcJJy0DgmcByhDll8i1JbcpXuw43Bta
	 08ZPQUwpQU21qQbLc0yp8qIy2xJbItDaLmcWdTA8JWoZ6/ESy38WfqOAjSnlthFw4q
	 7eSjXVJz9r28g==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Chris Bainbridge <chris.bainbridge@gmail.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Saravana Kannan <saravanak@google.com>,
 Sudeep Holla <sudeep.holla@arm.com>
Subject:
 [RFT][PATCH v4 0/2] PM: sleep: Handle async suppliers like parents and async
 consumers like children
Date: Mon, 23 Jun 2025 14:44:09 +0200
Message-ID: <5011988.GXAFRqVoOG@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 5.63.189.50
X-CLIENT-HOSTNAME: 5.63.189.50
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: dmFkZTG3zHbptXhQ2rOEtAqAw8vDfZ+PQ2olFRdKM0UOeCotRwcGzsAx8iQZgutWl2OiRKbIqxZKSpGvHFTxXViPl7VT2D6V3hUWQFwzUvk4V1QzeQvlUk6EnsE4msyRwv/9bJnlEjcPRtvImkqEutTcRlrstVT/XkbeP+kADdlMXK2T8VWSOAxSFZld0c8Bu5a2CPqSfMt45hOCwpw2kl8DrQ5Gu3qrbpPFyGgzaXYRYuLEktGyao0D+CVVF/Hi1I8EMZTNyIuei/XRUUzJz42HBNoQilXQPCQpxmC0r/3j9bMgim0Oo3U9YBCFOllvUEGXYsHxBhTXLDLRBT5I8B7rMZyWVBj6gmAn1k9a7safMnnxo17T6+v7xTdgjry9RciWAK71aKRfAD4ytGP1zLBEhSXBCez6BXI68p7lZFZxDcckGDfkBLQpNXhhJjHXlv35Y63GbHF4iRMU9SMDBot+7z4ELoEoma8JQJlX4oQd8GI4yjf4dNCpbMPpoRjoZBtWAv3Qrndc7pOmMvpUKdPks7BcrKSZ3wLAkpI6WN1mGQTuH7vgXZWL4FzpH/2mpeCerjLCO0FMJdj94iaRIMb9/K2V/IQD+mrh/vhxb1ePcjnQxIy+ZBMeVAfnuvdYnSRBTb3J0yprq9hPnbOlAWCvJwZ623eNpfnFvfsdehp2tVhqtA
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

Hi Everyone,

These two patches complement the recently made PM core changes related to
the async suspend and resume of devices.  They should apply on top of
6.16-rc3.

They were sent along with the other changes mentioned above:

https://lore.kernel.org/linux-pm/2229735.Mh6RI2rZIc@rjwysocki.net/
https://lore.kernel.org/linux-pm/2651185.Lt9SDvczpP@rjwysocki.net/

(and this is v4 because they have been rebased in the meantime), but they don't
make any difference on my test-bed x86 systems, so I'd appreciate a confirmation
that they are actually needed on ARM (or another architecture using DT).

Thanks!




