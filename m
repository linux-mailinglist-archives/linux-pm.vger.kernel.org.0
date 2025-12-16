Return-Path: <linux-pm+bounces-39635-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 541EECC3723
	for <lists+linux-pm@lfdr.de>; Tue, 16 Dec 2025 15:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8862430F21A6
	for <lists+linux-pm@lfdr.de>; Tue, 16 Dec 2025 14:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109403559C4;
	Tue, 16 Dec 2025 13:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WcKTp9jV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MKf5qMCK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="khe3Lupb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uuBBJWHw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6A6355053
	for <linux-pm@vger.kernel.org>; Tue, 16 Dec 2025 13:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765890050; cv=none; b=ma7Bc7lc1osBQOahcXa0oDanS/ysNU3A9kh0yFNWS2RjbZaN8Z895qAeEJ0JcBathaww6iTJcjsIkPasCKJ59j/No3Sj0NliIOpi7uThTNrMzD3vP1xj7eUCVw+Wzp5np7n2hPF2jBICtmiYzRSUU1J2iAh0ses2JuV5G7DXV5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765890050; c=relaxed/simple;
	bh=iQBFDWwef80LR5+luiz5ytPLcDzHlOj5h4YwPBNOX5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tsm9INwBjh8E4UsssOe5qoneOhqJNu+cw0Dg0LS27D/ScDspWWZ6azIULoawRcqeyzbAhKfxRYg72i4fxc+uLL6mL+8sZjChggTa2zzMdIQX0wMHyJSbWYSCJbRE3f9tr9pkOYofBKtajOGeRUkrKtojS3vcGw07bpLkSYbmlLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WcKTp9jV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MKf5qMCK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=khe3Lupb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uuBBJWHw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 600455BCD2;
	Tue, 16 Dec 2025 13:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1765890045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0FlmFMFG8z9tp2PIyRR+od1etRA+qYa6YsLRDcg0vsI=;
	b=WcKTp9jV6ypdwb1YpmuArdGB0TdBpfTQi4MQvOUd8SbW6lxJlH5fLa9xd6dCLsUSzvqvKi
	Wfub2UVDi/6Ii1Rcx4IWSJXWtOzys6irCD9kXoJA5wS1t9SDLihV/N/niQGU3c50SelzKf
	iz/M8OlHe3R5bXMAdcX1DpU+3IIbFg0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1765890045;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0FlmFMFG8z9tp2PIyRR+od1etRA+qYa6YsLRDcg0vsI=;
	b=MKf5qMCKH7Gp8rBI7KmgriIAJ2Z/eGoKy/r7hez2/+QkcMQl/WqIVQ95WoUzlz7uQRc04J
	bpTOAMdld7UQd7Dw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=khe3Lupb;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=uuBBJWHw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1765890044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0FlmFMFG8z9tp2PIyRR+od1etRA+qYa6YsLRDcg0vsI=;
	b=khe3LupbGRUn3uWTIMA1i0VYHLXhJ1GZf3alY6iBbXAzAZVUECVnewm7fWudpWf9okIp1u
	u+P28qFVQzPQ/sE5yaZ6QVzDYLpD3BA0UrIh8ax2aPRRPUsxoVv0bxbYmCowRsQk8VVlnn
	5pkiN9UKASgLZix+nX2+AVo1pGrnPB0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1765890044;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0FlmFMFG8z9tp2PIyRR+od1etRA+qYa6YsLRDcg0vsI=;
	b=uuBBJWHwLtlLveYFSpnrriSUi2Klz7bqzA4FfbRxYWkeWLnBts2MXO28uEoKl2RYEtPaGC
	yRdqK4wVapxQTKCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E4AC3EA63;
	Tue, 16 Dec 2025 13:00:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id twmoGPtXQWnLeQAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Tue, 16 Dec 2025 13:00:43 +0000
Message-ID: <189702e0-e6f0-44c5-bed6-eef058d90b76@suse.de>
Date: Tue, 16 Dec 2025 15:00:42 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] arm64: dts: broadcom: bcm2712: Add watchdog DT
 node
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Lee Jones <lee@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Willow Cunningham <willow.e.cunningham@gmail.com>,
 Stefan Wahren <wahrenst@gmx.net>, Saenz Julienne <nsaenz@kernel.org>,
 Andrea della Porta <andrea.porta@suse.com>,
 Phil Elwell <phil@raspberrypi.com>, Jonathan Bell
 <jonathan@raspberrypi.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>
References: <20251031183309.1163384-1-svarbanov@suse.de>
 <20251031183309.1163384-5-svarbanov@suse.de>
 <20251105165553.3910996-1-florian.fainelli@broadcom.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <20251105165553.3910996-1-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 600455BCD2
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,broadcom.com,linaro.org,gmx.net,suse.com,raspberrypi.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim,suse.de:email];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

Hi Florian,

On 11/5/25 6:55 PM, Florian Fainelli wrote:
> From: Florian Fainelli <f.fainelli@gmail.com>
> 
> On Fri, 31 Oct 2025 20:33:09 +0200, Stanimir Varbanov <svarbanov@suse.de> wrote:
>> Add watchdog device-tree node for bcm2712 SoC.
>>
>> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
>> ---
> 
> Applied to https://github.com/Broadcom/stblinux/commits/devicetree-arm64/next, thanks!

For some reason this is not part of v6.19-rc1.

~Stan

