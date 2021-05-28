Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0DC3394856
	for <lists+linux-pm@lfdr.de>; Fri, 28 May 2021 23:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbhE1Vbs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 May 2021 17:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhE1Vbr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 May 2021 17:31:47 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2F9C061574;
        Fri, 28 May 2021 14:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RwPljcSELGNhceB8xXbhE5fMRYWvw7Qw1owJPTo10sg=; b=RPyEXqqZU3gSlEDQZK9PoRH3d6
        FDfS2Y5gvMmdPokvdbxnbtU+BMaoLAqVYyGjPfFpbmDI2jefrblRgOJ0LjksFe12yPttv/gf1gYDl
        nDJWH6AiNkIKivCdJ9urQG7fdKEFzq6mB6UVLNNWc2IMlBsXOFk6/u23UZVJ8p2RN8fw=;
Received: from p200300ccff0cdc001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0c:dc00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1lmk3U-00005d-0V; Fri, 28 May 2021 23:30:08 +0200
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1lmk3T-0000yQ-N5; Fri, 28 May 2021 23:30:07 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 0/2] power: supply: rn5t618: Add more properties
Date:   Fri, 28 May 2021 23:30:04 +0200
Message-Id: <20210528213006.3695-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add charger type detection for devices which support it. Add also
current limits.

Andreas Kemnade (2):
  power: supply: rn5t618: Add charger type detection
  power: supply: rn5t618: Add input current limit

 drivers/power/supply/rn5t618_power.c | 235 +++++++++++++++++++++++++++
 1 file changed, 235 insertions(+)

-- 
2.29.2

