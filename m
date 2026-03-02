Return-Path: <linux-pm+bounces-43403-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPY7OX2KpWk4DgYAu9opvQ
	(envelope-from <linux-pm+bounces-43403-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 14:02:53 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A051D9656
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 14:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0EEC930488A2
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2026 12:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD48D3B3C0B;
	Mon,  2 Mar 2026 12:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TkwWD6PZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96072C11C6;
	Mon,  2 Mar 2026 12:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772456135; cv=none; b=no6FWp60W2c8ePjovnKmNbEUmxkw1pjPHFfIiaRP8vwsIjridCZpZRC5HBNuQV0mNRfQTBGXz3FCjKrs5SSYgW9s2CXtg3nhnmR5eSs/J78N+m0yzf3e1iPeQEOEIrwpf05KSLmfWQTP5yXIZk0LmvF19wFKHabMt5nUKrrG3EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772456135; c=relaxed/simple;
	bh=5q3JG5EiR7LxhydMW+Q6mZ0F0HhustgGLo0LL5/LuSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjUo7TZBBupD8j1u3X41Ow+NEpPCHKZc66XAhyy5tVc91bvNCtWZXs5tg055R6ACvBJKHBiyUAptaDQwdrbdR7WuKbZ14OXMwBULXluaVqby70mw8XGVTK1VussUkknE79PhAlSMMuwUblYBP6Yua3c84TQFg9dEwjDsjCABgIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TkwWD6PZ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772456134; x=1803992134;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5q3JG5EiR7LxhydMW+Q6mZ0F0HhustgGLo0LL5/LuSQ=;
  b=TkwWD6PZR+6a9nghjOqVc/I+L8MiaW34rtrkAT5nllzud4+59c1DmVon
   brgfcRFvkZRyguto2ahCpxyXUOVLx1PgxhYlLqzO1qtHPSHp80vVCWPzu
   Q7SIVPI6onrZ+7RdgfEFl/CzJZUXATo4YDtLG8XAgkukd43jsYvT5y/Cb
   LxvvTHbru+Au9yoeMggEfh9Vv+nbAxxYgCFoH1BLhaFH+dLcO2+2eHTUb
   IsxMzoV1L5RvitMtRPmCcBArDqZExeOwMzN30/rUsOlmLcBpc7mcrziP1
   oldLSZiwraxAejwT8IsLOY7Ezq2K1Hqad4pJZUwxi0tE3fO7tHY6+pyVK
   A==;
X-CSE-ConnectionGUID: snXTQ1X+QdOvTZtF/dS1Sw==
X-CSE-MsgGUID: iZzidX7TSU+esnXGHp4Rtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="72489024"
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="72489024"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 04:55:33 -0800
X-CSE-ConnectionGUID: aMyiej+FS/G5mq/xlIUOzg==
X-CSE-MsgGUID: PRfp/3AXSEajbcEvSpU/+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="214863125"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa006.fm.intel.com with ESMTP; 02 Mar 2026 04:55:31 -0800
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 9624198; Mon, 02 Mar 2026 13:55:29 +0100 (CET)
Date: Mon, 2 Mar 2026 13:55:29 +0100
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Badhri Jagan Sridharan <badhri@google.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Amit Sunil Dhamne <amitsd@google.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH v1 3/3] tcpm: Implement sink support for PD SPR AVS
 negotiation
Message-ID: <aaWIwQvxrAf-v5ec@black.igk.intel.com>
References: <20260226055311.2591357-1-badhri@google.com>
 <20260226055311.2591357-4-badhri@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226055311.2591357-4-badhri@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43403-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heikki.krogerus@linux.intel.com,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A3A051D9656
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 05:53:11AM +0000, Badhri Jagan Sridharan wrote:
> Add support to enable TCPM to negotiate with
> USB PD Standard Power Range Adjustable Voltage Supply (SPR AVS) when
> acting as a power sink.
> 
> * Added support to the tcpm power supply properties, allowing userspace
>   to enable and control the dynamic limits (voltage and current)
>   specific to the SPR AVS contract.
> * Implemented tcpm_pd_select_spr_avs_apdo() to select the appropriate
>   APDO and validate the requested voltage/current against both the
>   Source and Sink capabilities.
> * Implemented tcpm_pd_build_spr_avs_request() to construct the
>   Request Data Object (RDO) for SPR AVS.
> * Added SNK_NEGOTIATE_SPR_AVS_CAPABILITIES state to the state machine to
>   handle negotiation for SPR AVS.
> * Updated the SNK_TRANSITION_SINK state to implement the SPR
>   AVS-specific VBUS transition rules, including reducing current draw to
>   PD_I_SNK_STBY_MA for large voltage changes, as required by USB PD spec.
> 
> Log stub captured when enabling AVS:
> $ echo 3 > /sys/class/power_supply/tcpm-source-psy-1-0025/online
> $ cat /d/usb/tcpm-1-0025/log
> [  358.895775] request to set AVS online
> [  358.895792] AMS POWER_NEGOTIATION start
> [  358.895806] state change SNK_READY -> AMS_START [rev3 POWER_NEGOTIATION]
> [  358.895850] state change AMS_START -> SNK_NEGOTIATE_SPR_AVS_CAPABILITIES [rev3 POWER_NEGOTIATION]
> [  358.895866] SPR AVS src_pdo_index:4 snk_pdo_index:2 req_op_curr_ma roundup:2200 req_out_volt_mv roundup:9000
> [  358.895880] Requesting APDO SPR AVS 4: 9000 mV, 2200 mA
> [  358.896405] set_auto_vbus_discharge_threshold mode:0 pps_active:n vbus:0 pps_apdo_min_volt:0 ret:0
> [  358.896422] PD TX, header: 0x1a82
> [  358.900158] PD TX complete, status: 0
> [  358.900205] pending state change SNK_NEGOTIATE_SPR_AVS_CAPABILITIES -> HARD_RESET_SEND @ 60 ms [rev3 POWER_NEGOTIATION]
> [  358.904832] PD RX, header: 0x1a3 [1]
> [  358.904854] state change SNK_NEGOTIATE_SPR_AVS_CAPABILITIES -> SNK_TRANSITION_SINK [rev3 POWER_NEGOTIATION]
> [  358.904888] pending state change SNK_TRANSITION_SINK -> HARD_RESET_SEND @ 700 ms [rev3 POWER_NEGOTIATION]
> [  359.021530] PD RX, header: 0x3a6 [1]
> [  359.021546] Setting voltage/current limit 9000 mV 2200 mA
> [  359.023035] set_auto_vbus_discharge_threshold mode:3 pps_active:n vbus:9000 pps_apdo_min_volt:0 ret:0
> [  359.023053] state change SNK_TRANSITION_SINK -> SNK_READY [rev3 POWER_NEGOTIATION]
> [  359.023090] AMS POWER_NEGOTIATION finished
> 
> $ cat /sys/class/power_supply/tcpm-source-psy-1-0025/online
> 3
> 
> Log stub captured when increasing voltage:
> $ echo 9100000 > /sys/class/power_supply/tcpm-source-psy-1-0025/voltage_now
> $ cat /d/usb/tcpm-1-0025/log
> 
> [  632.116714] AMS POWER_NEGOTIATION start
> [  632.116728] state change SNK_READY -> AMS_START [rev3 POWER_NEGOTIATION]
> [  632.116779] state change AMS_START -> SNK_NEGOTIATE_SPR_AVS_CAPABILITIES [rev3 POWER_NEGOTIATION]
> [  632.116798] SPR AVS src_pdo_index:4 snk_pdo_index:2 req_op_curr_ma roundup:2200 req_out_volt_mv roundup:9100
> [  632.116811] Requesting APDO SPR AVS 4: 9100 mV, 2200 mA
> [  632.117315] set_auto_vbus_discharge_threshold mode:0 pps_active:n vbus:0 pps_apdo_min_volt:0 ret:0
> [  632.117328] PD TX, header: 0x1c82
> [  632.121007] PD TX complete, status: 0
> [  632.121052] pending state change SNK_NEGOTIATE_SPR_AVS_CAPABILITIES -> HARD_RESET_SEND @ 60 ms [rev3 POWER_NEGOTIATION]
> [  632.124572] PD RX, header: 0x5a3 [1]
> [  632.124594] state change SNK_NEGOTIATE_SPR_AVS_CAPABILITIES -> SNK_TRANSITION_SINK [rev3 POWER_NEGOTIATION]
> [  632.124623] pending state change SNK_TRANSITION_SINK -> HARD_RESET_SEND @ 700 ms [rev3 POWER_NEGOTIATION]
> [  632.149256] PD RX, header: 0x7a6 [1]
> [  632.149271] Setting voltage/current limit 9100 mV 2200 mA
> [  632.150770] set_auto_vbus_discharge_threshold mode:3 pps_active:n vbus:9100 pps_apdo_min_volt:0 ret:0
> [  632.150787] state change SNK_TRANSITION_SINK -> SNK_READY [rev3 POWER_NEGOTIATION]
> [  632.150823] AMS POWER_NEGOTIATION finished
> 
> $ cat /sys/class/power_supply/tcpm-source-psy-1-0025/voltage_now
> 9100000
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> Reviewed-by: Amit Sunil Dhamne <amitsd@google.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

-- 
heikki

