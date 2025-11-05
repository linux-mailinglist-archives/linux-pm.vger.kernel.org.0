Return-Path: <linux-pm+bounces-37464-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71954C35E24
	for <lists+linux-pm@lfdr.de>; Wed, 05 Nov 2025 14:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C3DF1890D6C
	for <lists+linux-pm@lfdr.de>; Wed,  5 Nov 2025 13:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BF6324B19;
	Wed,  5 Nov 2025 13:41:30 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1F7321457
	for <linux-pm@vger.kernel.org>; Wed,  5 Nov 2025 13:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762350090; cv=none; b=CUki6hQQz99PeXDiJCXGuTbfdcHo2e8M9UlHUhxDoylEKGz+z8O6rNeB5UVL6Jc7E+6sP+H45Y0VdWDpe1RNbJ2S+ZkXJoqwTlrVl0KxGdAm4Z2egMv0gFkKqL1XetQPAajeCupLjAwlkMGEdfTlRA8DBhRrx6lHXiGrpuGtGGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762350090; c=relaxed/simple;
	bh=bfdALSr3deXmp0lyQVG7MZh3VjiMH/EzHy4oWwL56vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=URA4G+Rb2io6k4kGkyu2DKjfMajd9QfaumuBJqzGbZAMW6bpkzHZ2V0vtrE8OH1255Zn4NcH8waIvy2j+DthWlEs37zuOKGUo3DYykdsK4gXOkCmpgJcL539fLrzffqVpskw3Uwtjmf43bw6ziWfB1et5qaHlRGkytBHfYjE7jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8B40C21195;
	Wed,  5 Nov 2025 13:41:20 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 89B98132DD;
	Wed,  5 Nov 2025 13:41:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HUsfH/9TC2liHAAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Wed, 05 Nov 2025 13:41:19 +0000
Message-ID: <dc641a92-51bb-4740-8aec-e6fd1ef988fa@suse.de>
Date: Wed, 5 Nov 2025 15:41:18 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] Add watchdog support for bcm2712
To: Ulf Hansson <ulf.hansson@linaro.org>,
 Stanimir Varbanov <svarbanov@suse.de>,
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, linux-pm@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Lee Jones <lee@kernel.org>,
 Willow Cunningham <willow.e.cunningham@gmail.com>,
 Stefan Wahren <wahrenst@gmx.net>, Saenz Julienne <nsaenz@kernel.org>,
 Andrea della Porta <andrea.porta@suse.com>,
 Phil Elwell <phil@raspberrypi.com>, Jonathan Bell
 <jonathan@raspberrypi.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>
References: <20251031183309.1163384-1-svarbanov@suse.de>
 <CAPDyKFqHizQKSDCuPopNBWtt1mNCNuWegv9c=PcXEEVaUaP3cw@mail.gmail.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <CAPDyKFqHizQKSDCuPopNBWtt1mNCNuWegv9c=PcXEEVaUaP3cw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: 8B40C21195
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[dt]

Hi,

On 11/5/25 2:52 PM, Ulf Hansson wrote:
> On Fri, 31 Oct 2025 at 19:33, Stanimir Varbanov <svarbanov@suse.de> wrote:
>>
>> Hello,
>>
>> Changes since v2:
>>  * 2/4 - Use maxItems instead of wrong minItems in else clause (Conor).
>>
>> Comments are welcome!
>>
>> regards,
>> ~Stan
>>
>> Stanimir Varbanov (4):
>>   pmdomain: bcm: bcm2835-power: Prepare to support BCM2712
>>   dt-bindings: soc: bcm: Add bcm2712 compatible
>>   mfd: bcm2835-pm: Add support for BCM2712
>>   arm64: dts: broadcom: bcm2712: Add watchdog DT node
>>
>>  .../bindings/soc/bcm/brcm,bcm2835-pm.yaml     | 38 ++++++++++++++++---
>>  arch/arm64/boot/dts/broadcom/bcm2712.dtsi     |  9 +++++
>>  drivers/mfd/bcm2835-pm.c                      |  1 +
>>  drivers/pmdomain/bcm/bcm2835-power.c          | 17 +++++++--
>>  4 files changed, 55 insertions(+), 10 deletions(-)
>>
>> --
>> 2.47.0
>>
> 
> Patch 1->3 applied for next, thanks!
> 
> Note the dt patch (patch2) is also available on the immutable dt branch.

Ulf, Florian, Conor, thank you for the help!

~Stan


