Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35FEC36CBED
	for <lists+linux-pm@lfdr.de>; Tue, 27 Apr 2021 21:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238963AbhD0TpR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Apr 2021 15:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238946AbhD0TpR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Apr 2021 15:45:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E258BC061574
        for <linux-pm@vger.kernel.org>; Tue, 27 Apr 2021 12:44:33 -0700 (PDT)
Date:   Tue, 27 Apr 2021 19:44:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619552672;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8l2DTofWYvWRCnJBwEwXkx9o86ocwWBl+5MXNtQtvQ8=;
        b=CaaS/t26pUZvPiubL45auk83w1ig4K0X07QLLAfoZBdW0lMI1ZqyucbOgHe1Th4LFJwnl5
        pbBmZ11EaGVElgvqVj143PQqcZjvo9Jam5QznhYc9fvqnhU/VXn0w5A/8enGKQ4P/rhAC7
        ZBApVUSd1dG+EXqK520MBnOf1ix16F+wGtXRLi2V9iD1lVHA7puHn4iqZzftcdrnJ2kr95
        Z3my5HD+f6P4aNNG8XqvDehxo3WnBTrgdj6RigFG47Pi0mwoMerFO5XfLvdY2gPMbKotDq
        XNr4pZ7X/V9hyL1g9E/+2KwFXEBcBliGtrUG3a+ofOKi3pmGDrjz2AGxA8m4xQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619552672;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8l2DTofWYvWRCnJBwEwXkx9o86ocwWBl+5MXNtQtvQ8=;
        b=9e8uQ3RzjmbH+weq28rZW6zQzLDefFjcNnNGuYs5ak5QdLrohewIzCrPkvfgL3MmLxE1n0
        CLAYSMHjbACcpLDQ==
From:   thermal-bot for =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] dt-bindings: thermal: thermal-sensor: require
 "#thermal-sensor-cells"
Cc:     rafal@milecki.pl, Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210415112121.4999-1-zajec5@gmail.com>
References: <20210415112121.4999-1-zajec5@gmail.com>
MIME-Version: 1.0
Message-ID: <161955267184.29796.4661105156582755515.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     bd5d553653e4151030ad2a94ef39a46b40c75a9b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//bd5d553653e4151030ad2a94ef39a46b40c75a9b
Author:        Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
AuthorDate:    Thu, 15 Apr 2021 13:21:21 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 20 Apr 2021 22:46:48 +02:00

dt-bindings: thermal: thermal-sensor: require "#thermal-sensor-cells"

This property is required for every thermal sensor as it's used when
using phandles.

Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210415112121.4999-1-zajec5@gmail.com
---
 Documentation/devicetree/bindings/thermal/thermal-sensor.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/thermal-sensor.yaml b/=
Documentation/devicetree/bindings/thermal/thermal-sensor.yaml
index 9f74792..4bd345c 100644
--- a/Documentation/devicetree/bindings/thermal/thermal-sensor.yaml
+++ b/Documentation/devicetree/bindings/thermal/thermal-sensor.yaml
@@ -36,6 +36,9 @@ properties:
       containing several internal sensors.
     enum: [0, 1]
=20
+required:
+  - "#thermal-sensor-cells"
+
 additionalProperties: true
=20
 examples:
