Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E12A434BC00
	for <lists+linux-pm@lfdr.de>; Sun, 28 Mar 2021 12:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhC1K0G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 28 Mar 2021 06:26:06 -0400
Received: from comms.puri.sm ([159.203.221.185]:56124 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhC1KZr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 28 Mar 2021 06:25:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id E8A3DE01BD;
        Sun, 28 Mar 2021 03:25:46 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tEz7Z80CCxMY; Sun, 28 Mar 2021 03:25:45 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     martin.kepplinger@puri.sm
Cc:     bvanassche@acm.org, jejb@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-pm@vger.kernel.org, martin.petersen@oracle.com,
        stern@rowland.harvard.edu
Subject: [PATCH v3 0/4] scsi: add runtime PM workaround for SD cardreaders
Date:   Sun, 28 Mar 2021 12:25:27 +0200
Message-Id: <20210328102531.1114535-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

hi,

In short: there are SD cardreaders that send MEDIA_CHANGED on
(runtime) resume. We cannot use runtime PM with these devices as
I/O always fails. I'd like to discuss a way to fix this
or at least allow us to work around this problem:

For the full background, the discussion started in June 2020 here:
https://lore.kernel.org/linux-scsi/20200623111018.31954-1-martin.kepplinger@puri.sm/

I'd appreciate any feedback.

Especially: Any naming-preferences for the flags? And is the specific
device that I need this workaround for (Generic Ultra HS-SD/MMC, connected
via USB) too "generic" maybe? Not sure about what possibilities I'd have here...


revision history
----------------
v3: (thank you Bart)
 * create a new BLIST entry to mark affected devices instead of the
   sysfs module parameter for sd only. still, only sd implements handling
   the flag for now.
 * cc linux-pm list

v2:
https://lore.kernel.org/linux-scsi/20210112093329.3639-1-martin.kepplinger@puri.sm/
 * move module parameter to sd
 * add Documentation
v1:
https://lore.kernel.org/linux-scsi/20210111152029.28426-1-martin.kepplinger@puri.sm/T/


Martin Kepplinger (4):
  scsi: add expecting_media_change flag to error path
  scsi: devinfo: add new flag BLIST_MEDIA_CHANGE
  scsi: sd: use expecting_media_change for BLIST_MEDIA_CHANGE devices
  scsi: devinfo: add BLIST_MEDIA_CHANGE for Ultra HS-SD/MMC usb
    cardreaders

 drivers/scsi/scsi_devinfo.c |  1 +
 drivers/scsi/scsi_error.c   | 36 +++++++++++++++++++++++++++++++-----
 drivers/scsi/sd.c           | 23 ++++++++++++++++++++++-
 include/scsi/scsi_device.h  |  1 +
 include/scsi/scsi_devinfo.h |  6 +++---
 5 files changed, 58 insertions(+), 9 deletions(-)

-- 
2.30.2

