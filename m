Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE6516BA8A
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2019 12:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbfGQKsb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jul 2019 06:48:31 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:36748 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfGQKsb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jul 2019 06:48:31 -0400
Received: by mail-oi1-f178.google.com with SMTP id w7so18108023oic.3;
        Wed, 17 Jul 2019 03:48:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=bvfEvsj27j9s8qMur8gvYFEu77AHAGnRCqkVRfegmkQ=;
        b=cWlLA7a1OVjk1RWiE/xC+SrunH8terYSYcrzNT/06yrKlW3H1oyl90otm9FfveX8Mw
         rxM98xhj+y43xwIllJBIpTTAyesXUbrhn9/k/v/RpT+XeMlGEQCkiKEdbEW2ieP9f9ZP
         gD8nrGHC3m28LCNZ8FL/fziQwjWk5rs0JBgIKzFMGLugUhUl6DFTbl9rEcdZBlEnp9TC
         L/IEDV7ToTnYHO/DxDANhzkwwkE6q+9v5uRWZRiayVGHJlDH5FJ46Iv8lPb2uXfc54Ib
         QNkVlKmRPc9EXmEqqL2WFfsVhUx7tFmdIbtv86judwBd4v/3e622MwWGWsbCzebNtmBe
         lT2g==
X-Gm-Message-State: APjAAAVe1DKCvW8QNuC4Jv3jL7BdsXDLx/B72Uckr6G7vl/I8urvR2Wm
        wTS2VtRUKMPFw651f3OEUZJ0rQ6ZBZzOw6cNYJVfXDYM
X-Google-Smtp-Source: APXvYqyvLt2x3jI5UIFxEZbDTlsn5zNxQYrtboH7mw0dB2JI07Ix/X6Pww9sunz/9xzrsizF/8Mo4j4Bcao3tKrYN7g=
X-Received: by 2002:aca:5a41:: with SMTP id o62mr19263570oib.110.1563360510411;
 Wed, 17 Jul 2019 03:48:30 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 17 Jul 2019 12:48:19 +0200
Message-ID: <CAJZ5v0hrpO_PRos3=JnLQ0ZbuBX1vdR8j2jx3je5+Y2m=Dwk2A@mail.gmail.com>
Subject: [LPC 2019] Power Management and Thermal Control MC: Call for topics
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi All,

Now that the PM+Thermal MC has been officially announced

https://linuxplumbersconf.org/event/4/page/34-accepted-microconferences#pm-tc

everyone interested in the problem space in question and having a
topic for discussion is kindly requested to submit a topic proposal
for that MC via the LPC web site:

https://linuxplumbersconf.org/event/4/abstracts/

To do that (after following the link above):

1. "Press" the "Submit new proposal" button.
2. Log in to the LPC CFP system (* see below in case you don't want to
create an account).
3. Put a one line title of your topic into the "Title" field.
4. Put your abstract into the "Content" field (please keep the
abstracts concise).
5. Add yourself as the author (there may be multiple authors, in which
case add all of them).
6. In the "Comments" field say how much time the topic is expected to take.
7. Choose "Power Management and Thermal Control MC topic" in the
"Track" selection.
8. Answer "Yes" to the anti-harassment policy compliance confirmation.
9. "Press" the "Submit" button.

* In case you don't have an account in the LPC web site and you don't
want to create one, you can send the topic title and abstract to me,
and I will put the proposal into the LPC CFP system for you. Still,
please do consider adding an LPC account and following the steps above
yourself.

Please note that the most relevant topics are those aimed at solving
specific problems in the Linux "plumbing" area: the kernel, libraries,
system management tools etc.

Thanks,
Rafael
