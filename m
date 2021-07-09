Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16ECE3C2665
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jul 2021 16:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbhGIO7N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Jul 2021 10:59:13 -0400
Received: from server34.i7host.com.br ([186.227.200.26]:41232 "EHLO
        server34.i7host.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbhGIO7M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Jul 2021 10:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=smartgreen.net; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9sBfKIgHuQukWy84rgMEl4tx62Eh81wsX/GQxfKJxro=; b=TvObv5UvjinVCUpxLskYD8IEn9
        2S37jNFc5TZanPYahDk1JXbxQ1X9XGQGHUt4Y4YlPXHLcBe0wEv09N7EZn6DZ4F1kxI4AI0STRlq5
        Jgu3IEgvJbRlF0o/z0B4AAFSmXCqbzOVmJAjjJpW9BMI6Uu10MXQME+875IKxvp6ztDFZRUgg8KZx
        XXmTpdz0P1dMDvg/XQWf1aIR3xSmZgEG//6oXOPGkkekI+B9cplImEBQhUm5L4jeZoU5DO8NtgHX5
        bJVYn3TglFdbAPaFdnURZt6869bRjeU5DedNyVpTefoUXxzk8fyjDchymF/feaeGFeAsPBQNanfeh
        m7ik3m6g==;
Received: from [177.220.172.135] (port=48444 helo=localhost)
        by server34.i7host.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <bruno.meneguele@smartgreen.net>)
        id 1m1rTX-004uW1-3E; Fri, 09 Jul 2021 11:27:32 -0300
From:   Bruno Meneguele <bruno.meneguele@smartgreen.net>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] add Watchdog Timer delay support for BQ24735
Date:   Fri,  9 Jul 2021 11:27:29 -0300
Message-Id: <20210709142731.23418-1-bruno.meneguele@smartgreen.net>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server34.i7host.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - smartgreen.net
X-Get-Message-Sender-Via: server34.i7host.com.br: authenticated_id: bruno.meneguele@smartgreen.net
X-Authenticated-Sender: server34.i7host.com.br: bruno.meneguele@smartgreen.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The IC BQ24735 has the ability to suspend the battery charging in case the
system freezes for some reason: the IC observes consecutive writes for
either CargeCurrent of ChargVoltage registers in a maximum period of time.

This period of time can be configured by the user through the ChargeOption
register in the bits 13 and 14, but it's only possible to change if the user
sends the value directly accessing the I2C bus through userspace, because
the kernel driver doesn't read or write to the Watchdog bits.

This patchset enables the user to configure the value through the
device-tree option "ti,wdt-timeout".

Changelog:
  v2 - unfortunately I used a default gitconfig that was pointing to my
  default user.email and email smtp. This new version corrects it.

Bruno Meneguele (2):
  power: supply: bq24735: reorganize ChargeOption command macros
  power: supply: bq24735: add watchdog timer delay support

 .../bindings/power/supply/bq24735.yaml        | 13 ++++
 drivers/power/supply/bq24735-charger.c        | 75 ++++++++++++++++---
 include/linux/power/bq24735-charger.h         |  1 +
 3 files changed, 77 insertions(+), 12 deletions(-)

-- 
2.31.1

