Return-Path: <linux-pm+bounces-40609-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 851B5D0E87D
	for <lists+linux-pm@lfdr.de>; Sun, 11 Jan 2026 11:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77FBD3004197
	for <lists+linux-pm@lfdr.de>; Sun, 11 Jan 2026 10:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595602153FB;
	Sun, 11 Jan 2026 10:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=glanzmann.de header.i=@glanzmann.de header.b="q9S0ka3P"
X-Original-To: linux-pm@vger.kernel.org
Received: from infra.glanzmann.de (infra.glanzmann.de [88.198.237.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1737F330D26
	for <linux-pm@vger.kernel.org>; Sun, 11 Jan 2026 10:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.198.237.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768125845; cv=none; b=DbQIoD1rEMM7TakHEl0IhqSm9t+4zYgA/KiQuyRCbsVhXHo6My9I8rjhAqRHeqvPJmoZaHCwLlC8lQpse1BlDedUZ0QXbgl4MtLU5beIyR7vMcD00knZoRinfa4Ta1cjW8tTyx4joUiRDKNO3+GcmKLm3T8Nuw7c/W6LeIZFIdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768125845; c=relaxed/simple;
	bh=+Qr++2pn+G9P1Wbp0wued+I2cW+a4O1pw3PPKfjUUmg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KmD4TTsrEPY4gV1ZV8yTclK+GElkIVltEL6DymCOw0dAb8ChnDJoNZvFs9HkJc3/g7E/wW9TWJzKCdHOB31q0ZwsFu9Jb4aj5PJQKeraOAVRZrbBlm2a7RddA0o5uyhYGj5DQpA2eqEjn58WyLggSqSiNsclKZ6akh1SkJIfw2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=glanzmann.de; spf=pass smtp.mailfrom=glanzmann.de; dkim=pass (4096-bit key) header.d=glanzmann.de header.i=@glanzmann.de header.b=q9S0ka3P; arc=none smtp.client-ip=88.198.237.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=glanzmann.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glanzmann.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=glanzmann.de;
	s=infra26101010; t=1768125492;
	bh=o9T60oGP0rBiEbcHMzEGDNjLwu4Dl2Apvz9XEgKR5tE=;
	h=Date:From:To:Cc:Subject:From;
	b=q9S0ka3PKIXk6XBZ3mGCn8kUnbbJx3EB6rXzbpj0Jj+FRmh90/hl2XKWnhcvBWfV+
	 K+FDGhxFp/N86XkJGORdqdTDz/DtBTosdiHSr/Z6NhzwmcaCW3vBv9DxNWnaD39NWR
	 5vxlL+I+Q9KgGQD1Oi8egWMRlJ9UKIOnypaArIQNDSxOkXNWCyKNNYY0OpasKRTrsE
	 4X3QWpHbhFDgbDf+e5VpH/FSdF6zxvftJ/BSVI6bpOYkr2hgZHivy7xLOTahyIY6uS
	 xox5UQhoFC8MFRkaT838+F44d8XKiYCm+jjHxtAAH7TNg0yGRPrVL4WpwKmw/TrW8z
	 1zXuxmc7wo32eqSP9ZwfMh6LYxQFTlhBK1rcEnEqEtkCT75yzZDn5BbeBKQALkooA6
	 7IP4dU3UmQc650KNkPNjqjTTojHVpYC9L91h/3b3/rAHvn4AVKOFPY6804R86/aCGO
	 KZwOPZvseYl1Fw3AgjeooAkip1D9SpQK9OIPEcEizb9Um6LvS4YcKTxkA5cUq9LpiY
	 EMpzNzetH4H2BNjdMyOEju7FujwQYCLzVW+5ZG0NTEY54hv+gw/Yd0vV4HI7xl8KjX
	 4CaQOQZDAPR1Y4oc8PvCPo8ePrjvXcfDy+WzWSrDiWppHgO03CBXFl8Q9S3cuxySQW
	 O0Pb5NWqASmBEawfztJQ/yUY=
Received: by infra.glanzmann.de (Postfix, from userid 1000)
	id 2AE4227A333; Sun, 11 Jan 2026 10:58:12 +0100 (CET)
Date: Sun, 11 Jan 2026 10:58:12 +0100
From: Thomas Glanzmann <thomas@glanzmann.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, linux-pm@vger.kernel.org
Cc: Sven Peter <sven@kernel.org>, asahi@lists.linux.dev
Subject: Proper way to disable hibernate for a platform
Message-ID: <aWN0NOls6XIj5oXh@glanzmann.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hallo,
arm based macs do not support hibernation at the moment, sometimes they
crash, sometimes they try to stop the cpu, can't and abort the attempt.
What is the porper way to tell hibernation code that suspend is not
available on that platform?

Looking at the code in kernel/power/hibernate.c it appears that
hibernation_available is the right place to do it:

bool hibernation_available(void)
{
        return nohibernate == 0 &&
                !security_locked_down(LOCKDOWN_HIBERNATION) &&
                !secretmem_active() && !cxl_mem_active();
}

Or is there a better way? How would a platform agnostic interface best look
like, something allong the lines:

dmi_check_system(hibernate_blacklist)

Or ist there a better way?

Cheers,
	Thomas

