Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61125596A0D
	for <lists+linux-pm@lfdr.de>; Wed, 17 Aug 2022 09:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238715AbiHQHIl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Aug 2022 03:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238741AbiHQHIi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Aug 2022 03:08:38 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62A02F64E
        for <linux-pm@vger.kernel.org>; Wed, 17 Aug 2022 00:08:33 -0700 (PDT)
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C9BBC3F0EB
        for <linux-pm@vger.kernel.org>; Wed, 17 Aug 2022 07:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1660720110;
        bh=+cyCgN7T+WAshZqStiQr/PXrCFKi9+/McRxd4iwdYdI=;
        h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type;
        b=SLLLRBciQaTq5kR0NhNSLel5DKB2LUOcKR1lCd60Yiru8OIj4Tcm91+UXHoOYsrdM
         9RjnfJwbHlDpDpEv4T/gLq6A6oSm7ZrSGeKoTK/OwB0IjCLmKlu6MytQM9eumn+Dk4
         eMBw42Hb6/4xC0NGeGGs+dXbaVXO9AUD6yT4UYZzi5tCkM02Gg4kXIQoSx73sOUyUO
         Xw+ov43UWOggo83uiNqhKAH76QsY8JXfV813HyvmKcRn06j2aWTZ9ErDsXl0n6PsgZ
         E8k0uEBlYeoN2x9QERi3IbKq/CT2fEdKdUusjUGFhlJRyQXpUWfNuoniPjmeAgJ4Hx
         R7kJusLpRt4Iw==
Received: by mail-oi1-f199.google.com with SMTP id y126-20020acae184000000b00343644f7ddeso3498011oig.2
        for <linux-pm@vger.kernel.org>; Wed, 17 Aug 2022 00:08:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=+cyCgN7T+WAshZqStiQr/PXrCFKi9+/McRxd4iwdYdI=;
        b=57++BkWsjEladLJm7rwc7DZwFDY6EdbeiVtAE5rYS72foxsH7UwRN/CiMHHvkoTGSE
         ZiDuBPpSPHZMdmvOTiGHmobgTIlA3rEm44ksKaNMbIUZS+9NvZYFLojJgZzEBEAHgHe3
         11nzoTaDWrZYWCSNn8eUgBdWrJUHi7CKiPTXkLIjJC+lgir3PTunPl5oQTRTYkt4xsPz
         0kAA++o/uY4rz2SwR1xHhmQUhmX1VdjEBh2uVjgfLfGgfnhbXMoWHKghpXJrF8EH+AKK
         xHR8rSA5FpcqZC9gcmwBWwLPA2WGOctK+avgTSPQFRBcoCWxC5HbRNtxTBvODMOkTe76
         MQrg==
X-Gm-Message-State: ACgBeo1Q+4SP9/Dj/ddaFBAL8UCeyAdQeNAnXogicexAHD1pi6Ja6iBj
        qSJCPY8gxrd8zLjFOuHEly8kpCYqFPs3HMJFGMx7SF12ajASREmeeF2VwKdHUOMym1dG+n9DuwP
        /sws7uUUEEC6jWXEknZKiiWtZEqTbCXa2QfZBJoAf7b9tZjSLjwAA
X-Received: by 2002:a05:6871:28c:b0:10e:a56a:1c47 with SMTP id i12-20020a056871028c00b0010ea56a1c47mr1056468oae.176.1660720109742;
        Wed, 17 Aug 2022 00:08:29 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4klyTZIlTtDvXHbhxllNWZO+1SQWUnb8zyF4OQFSY9WsdsYNAovekpvnO5y3Wmm5rluRnthXNcYyl5GsTJTco=
X-Received: by 2002:a05:6871:28c:b0:10e:a56a:1c47 with SMTP id
 i12-20020a056871028c00b0010ea56a1c47mr1056464oae.176.1660720109484; Wed, 17
 Aug 2022 00:08:29 -0700 (PDT)
MIME-Version: 1.0
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 17 Aug 2022 15:08:18 +0800
Message-ID: <CAAd53p6VowO3WJt4mUJtxJenL8qbxtPFtXGjgiMkckX71bPrfw@mail.gmail.com>
Subject: How to get "wake up reason" for Suspend-to-Idle
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We are seeing laptops wake up when Thunderbolt dock gets plugged, or
even wake up on AC plugging.

On Windows these events are logged with "Wakeup Reason", and if the
wakeup event is from unplugging AC, the system will be put to suspend
again.

So I wonder if it's possible to get the "Wakeup Reason" under Linux?

'/sys/power/wakeup_count' seems to be insufficient for this purpose.

Kai-Heng
