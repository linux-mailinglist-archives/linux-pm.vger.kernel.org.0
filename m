Return-Path: <linux-pm+bounces-37774-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B10C4B94C
	for <lists+linux-pm@lfdr.de>; Tue, 11 Nov 2025 07:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DD001890B33
	for <lists+linux-pm@lfdr.de>; Tue, 11 Nov 2025 06:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD3C1A317D;
	Tue, 11 Nov 2025 06:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D4ewmslm"
X-Original-To: linux-pm@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0052AD1F;
	Tue, 11 Nov 2025 06:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762840818; cv=none; b=AMIBYzXTzNjy4ctKMfjUsyfx/1Ch7fMTvhKQdTgp7kTuKQt1OVYqhGB/iabJ0++XNQ2DjwjhrOA/yvkvJ8bZQhpwCPmayEXmDo2I83TIjZkovrrjgCCzCqtvNrUOLLrnCAN/K/C4HoOGl7kSlrlj6TFMOVaeEGTSLobk8//JXow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762840818; c=relaxed/simple;
	bh=EdOqdySR24uR3G1tafJApEIPQH+yf+c+cTZ/Kcxlu+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CRgNEr5gx1HOQROvMoZ/mwvEbBwqID2qyhRuvagdXClZpSdTmzoiSFaXj0sA+xWW/CjvUZMzckjlpcl11yg4tl1umBeaW2DmWpaa9ydOOKX4Y1excfws+kJpYncUoLs3BYWsZVlFS8TvRpN+iDm9vKEJRS5Ob5MaV6NA3p1WwIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=D4ewmslm; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=AnjI+YlcCDEKPvDLLvf5t78gzh87TDaI+olc2x9lr04=; b=D4ewmslmHOfoy1tRnL7VxiRp/A
	LuuUy3lRjxEgLWUJCu8LRo79j5E261cRGV14MusHqZ7o483CqlOOGlV2RbUSMo2/KYGoCAhvU9kN0
	WQCxglWoTCBL4ZhUFkXqFXxjIdR2ufiXVqN5piGyCp9yMwU14AcubMpl3VeZILozZjWfXIu6xZf6N
	eWNCdxv3KaEIZfIbTGiZjzjl2pb2Flk7GuivylqnPuAV2zxS4pbD0JO6eZJnRZxwsXv8htCG2otyo
	Jr2WKhdSbp0hc5cEBKqCdui5TjuQ8dO/7l38afmyY/tkni64PLgu7BHo9EEtHwOVhlTcT1cAMK4fY
	CAO6XERw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIhQI-00000006aU8-3DEh;
	Tue, 11 Nov 2025 06:00:10 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH] power: supply: ab8500_chargalg: improve kernel-doc
Date: Mon, 10 Nov 2025 22:00:09 -0800
Message-ID: <20251111060009.1959425-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct "bad line" warnings and add descriptions for missing entries
to avoid these warnings:

ab8500_chargalg.c:173: warning: bad line:  is set
ab8500_chargalg.c:179: warning: bad line:  increased
ab8500_chargalg.c:247: warning: Function parameter or struct member
 't_hyst_norm' not described in 'ab8500_chargalg'
ab8500_chargalg.c:247: warning: Function parameter or struct member
 't_hyst_lowhigh' not described in 'ab8500_chargalg'
ab8500_chargalg.c:247: warning: Function parameter or struct member
 'ccm' not described in 'ab8500_chargalg'
ab8500_chargalg.c:247: warning: Function parameter or struct member
 'ac_chg' not described in 'ab8500_chargalg'
ab8500_chargalg.c:247: warning: Function parameter or struct member
 'usb_chg' not described in 'ab8500_chargalg'
ab8500_chargalg.c:308: warning: Function parameter or struct member
 'state' not described in 'ab8500_chargalg_state_to'
ab8500_chargalg.c:773: warning: Function parameter or struct member
 'di' not described in 'ab8500_chargalg_chg_curr_maxim'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org
---
 drivers/power/supply/ab8500_chargalg.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

--- linux-next-20251107.orig/drivers/power/supply/ab8500_chargalg.c
+++ linux-next-20251107/drivers/power/supply/ab8500_chargalg.c
@@ -170,13 +170,13 @@ struct ab8500_chargalg_events {
  * @original_iset_ua:	the non optimized/maximised charger current
  * @current_iset_ua:	the charging current used at this moment
  * @condition_cnt:	number of iterations needed before a new charger current
-			is set
+ *			is set
  * @max_current_ua:	maximum charger current
  * @wait_cnt:		to avoid too fast current step down in case of charger
  *			voltage collapse, we insert this delay between step
  *			down
  * @level:		tells in how many steps the charging current has been
-			increased
+ *			increased
  */
 struct ab8500_charge_curr_maximization {
 	int original_iset_ua;
@@ -199,18 +199,20 @@ enum maxim_ret {
  * @charge_status:	battery operating status
  * @eoc_cnt:		counter used to determine end-of_charge
  * @maintenance_chg:	indicate if maintenance charge is active
- * @t_hyst_norm		temperature hysteresis when the temperature has been
+ * @t_hyst_norm:	temperature hysteresis when the temperature has been
  *			over or under normal limits
- * @t_hyst_lowhigh	temperature hysteresis when the temperature has been
+ * @t_hyst_lowhigh:	temperature hysteresis when the temperature has been
  *			over or under the high or low limits
  * @charge_state:	current state of the charging algorithm
- * @ccm			charging current maximization parameters
+ * @ccm:		charging current maximization parameters
  * @chg_info:		information about connected charger types
  * @batt_data:		data of the battery
  * @bm:           	Platform specific battery management information
  * @parent:		pointer to the struct ab8500
  * @chargalg_psy:	structure that holds the battery properties exposed by
  *			the charging algorithm
+ * @ac_chg:		AC charger power supply
+ * @usb_chg:		USB charger power supply
  * @events:		structure for information about events triggered
  * @chargalg_wq:		work queue for running the charging algorithm
  * @chargalg_periodic_work:	work to run the charging algorithm periodically
@@ -300,6 +302,7 @@ ab8500_chargalg_maintenance_timer_expire
 /**
  * ab8500_chargalg_state_to() - Change charge state
  * @di:		pointer to the ab8500_chargalg structure
+ * @state:	new charge algorithm state
  *
  * This function gets called when a charge state change should occur
  */
@@ -763,7 +766,7 @@ static void init_maxim_chg_curr(struct a
 /**
  * ab8500_chargalg_chg_curr_maxim - increases the charger current to
  *			compensate for the system load
- * @di		pointer to the ab8500_chargalg structure
+ * @di:		pointer to the ab8500_chargalg structure
  *
  * This maximization function is used to raise the charger current to get the
  * battery current as close to the optimal value as possible. The battery

