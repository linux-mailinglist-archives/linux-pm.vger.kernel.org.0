Return-Path: <linux-pm+bounces-33592-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 727FFB3F192
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 02:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB1E87AADD7
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 00:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB002DE710;
	Tue,  2 Sep 2025 00:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="iUZyk4Gy";
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="LEDezIOZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FC7CA5E;
	Tue,  2 Sep 2025 00:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756772502; cv=none; b=vBbKaVm2h4/RHX2liqatUaI4pBuh2eqE9zwCIk8ledRkkH8qoY/0qI6S4xUNUyZeJ7FJrhYuVO7yphdLe2dXSv8EaITpwpwEcS9oWdkB5Pz5g81T0ZfJV7VUw3yRs+aOA6iPj/psCFwioSRZpz50ND3Q5+r3BxZ0FwSwQay013w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756772502; c=relaxed/simple;
	bh=PRa0mSppoqy3kRhqnEoKQZAtPpLwcntx97ZBMNdAcJg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUzHkc9E9Ba5p+C7zzZFZr6rmB0RMR/nQ6gC9/Dlv8xpWsMZ2LwGnhlN8iB5B4H8tasJrcPiytndXJhlKsRjYb0HXfnrjHm5M/moYjrFaYgNYTNUyjeyzApKkwUglkF5wjw9CIUS64mlrrEu6n3Veeby0ggCVTTXIG7ix/h02ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=iUZyk4Gy; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=LEDezIOZ; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1756772497;
	bh=qUayv2HfVuXw1yRAHXbE4d3I6zvcZXB9WBLthXrHpZg=; l=506;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=iUZyk4Gy57KkVaCMTm/It4EM3OttxAMevAeazUqvYr/QF9vF/5dlrQAp4kfJAAyiF
	 fWwCdb5h/C2VYc4aZKjQ5L5e9SorwjGOon8X7zRflr89id6R6+9NJc7NSdhL9Tuz/s
	 C7e3/fyZ9r1OTtyphusPaUzP8ZM6KoISGfed+LrX8Rnrd4KkdkrnSpQ7eKIT2LaEOr
	 4wfXcLLy2uqeQEonSTn+4R1KQHq+vLc7JeXfYWe1h50zgLDNsKkg27BcMhC0To6iXf
	 qMxLylbIhTn3PWj85s67UO/j4MSwMZLo7ptH47re//VviOHyVJGmJfVTFBam9mQwEv
	 Z2EGJIHZzWf0w==
Received: from 192.168.8.21
	by mg.richtek.com with MailGates ESMTP Server V3.0(1128077:0:AUTH_RELAY)
	(envelope-from <prvs=13385C53C6=cy_huang@richtek.com>); Tue, 02 Sep 2025 08:21:36 +0800 (CST)
X-MailGates: (compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1756772495;
	bh=qUayv2HfVuXw1yRAHXbE4d3I6zvcZXB9WBLthXrHpZg=; l=506;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=LEDezIOZ5Nbb+vMcpXs+t8Tza39sP6TT+sxZozMt2489qhrhlywxWI9KuVVwC6Rmt
	 PgWmJcgBy4TM6/PBoAeEi2RMlSATMxRN+H/xb/PB1HUy3zu4TdBLFYTgykXwTUCHYQ
	 ALzxK2jjbyPXxU+4ECf30E/lFf8TprFE4oZ+tkX7wGkkZLAgXtYL0w5SI93VNjwe20
	 nlfTbp6odmM+imi2qo2JSRL7iJl5FoLfnjexFTu2FIXyyK7FPxeMM8ZSACseiCP4jD
	 VKm/18QdMQr8XYHwjnYlzD2/53GSatIWttcpY9gX5DiEKXl7z87IBjY7u+4tXCCQhB
	 HcW9KJT9LJydg==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(2461115:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Tue, 02 Sep 2025 08:18:07 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.26; Tue, 2 Sep
 2025 08:18:06 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1748.26 via Frontend
 Transport; Tue, 2 Sep 2025 08:18:06 +0800
Date: Tue, 2 Sep 2025 08:19:09 +0800
From: ChiYuan Huang <cy_huang@richtek.com>
To: Sebastian Reichel <sre@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>
CC: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND v2 0/3] Add Richtek RT9756 Smart-Cap divider
 charger
Message-ID: <aLY3/dNLdF/Iiwq6@git-send.richtek.com>
References: <cover.1755154950.git.cy_huang@richtek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1755154950.git.cy_huang@richtek.com>

On Thu, Aug 14, 2025 at 03:31:05PM +0800, cy_huang@richtek.com wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> This patch series adds support for RT9756 charger.
> 
> RESEND V2
> - Add 'Reviewed-by' tag in dt-binding patch
> 
> V2
> - Add reference to 'power-supply.yaml'
> - Remove 'wakeup-source' from required property list
> - Use 'unevaluatedProperties' to replace 'additionalProperties'

Ping......
It's been one month not receive any patch review comment.

Regards,
ChiYuan.

