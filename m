Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CDF63403F
	for <lists+linux-pm@lfdr.de>; Tue, 22 Nov 2022 16:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiKVPfR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Nov 2022 10:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbiKVPfQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Nov 2022 10:35:16 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAE8697F2
        for <linux-pm@vger.kernel.org>; Tue, 22 Nov 2022 07:35:15 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id b11so13557494pjp.2
        for <linux-pm@vger.kernel.org>; Tue, 22 Nov 2022 07:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vLXx8s2tHi2ef+9rJW+smmgw1F1tWCHZvSCKADXYsso=;
        b=p2US4siEm65dZPd/JKwNmREIsN9DsbcqwPozK3HmHMd2WsKkb48/Zaf6eoUEg8adKH
         XEQwa5VYlb+H9A/9wHcNmsZ7CZQJHL4FZvu/gnxqSOVImtwgyGdb3LLgE3WWPXywdF1k
         Eog3XrvFEVAdRbN+qRlo9jG997+KgjsPfZ5K8OI7+LzadVX6yTiS5j1kWwqDOXjuMKpX
         R6u0gUAXOSgeYNudr/uNqvstghJkBuJdc7QWLzgAfOYN3z4o7Cbv3H9vIcld27+fT7uo
         n47MrWdctzSVKeidK+U2JBXF8RI34tghCTADcWPbJTQmugOYxwLJbKxxWlNfRbrl5lgM
         k+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLXx8s2tHi2ef+9rJW+smmgw1F1tWCHZvSCKADXYsso=;
        b=g9o0QLNCXCa35qhmkZBtaeQHcjQSDv05YVzN8H+hQ4psXp2N0KpCuxo2TTuHhs6PPN
         E8ap0QRH9MQVRyJHtHWkbUTVtscdA91fGL5levDPwZs0iu6ZsC0G1+vGZli+cyF0XKNt
         eI/X7e58LuVm+WwEz5pRLZhLOofJawQQse+KYLY41Jzxx0bFX64hTcHYSVH/IZ6WTiTY
         w/V70FIbMjSpsCe84+wuOtlabRMjynlv8ah/W+9lx38tJCloTbInZLtLh7XRjSVWcMKF
         VmJXlyYIL3vhevxM4QEwaPOXZ/WL3/yIv302WXYNxunfwDEU5Lw32zHnNa+xWmmu0FVi
         YjUQ==
X-Gm-Message-State: ANoB5pkxvDU+XoPB01XAumSoo3CahJwH63qb3NC5GY8nVh83YtkgTUIZ
        jLPNrBfdDq6GDb7tFrIaQZ0HjaLRJG1fEufFy94=
X-Google-Smtp-Source: AA0mqf7qv7d8lL7ZUnWvBgkI7gwAUlW9V7U0Wz5A4s4nNr2ZudezHQ9Lcl3d7HApUgwf8alk3Sepy2mGmcKdAB+x5j0=
X-Received: by 2002:a17:90a:1f81:b0:218:a672:bca0 with SMTP id
 x1-20020a17090a1f8100b00218a672bca0mr13370271pja.7.1669131315331; Tue, 22 Nov
 2022 07:35:15 -0800 (PST)
MIME-Version: 1.0
Reply-To: sgtkalamanthey@gmail.com
Sender: tchipoakakokoubernard@gmail.com
Received: by 2002:a05:6a10:e90a:b0:35c:d2b:dd3 with HTTP; Tue, 22 Nov 2022
 07:35:14 -0800 (PST)
From:   kala manthey <sgtkalamanthey@gmail.com>
Date:   Tue, 22 Nov 2022 07:35:14 -0800
X-Google-Sender-Auth: jtni7QyxnbFZkyvEWmW7N7IAnkE
Message-ID: <CABhZMZ9Js3vnm6ny_Q55DL=2LDQw4VKWVwtPPUGPb6Mjacq09Q@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

0LfQtNGA0LDQstC10LksINC/0L7Qu9GD0YfQuCDQu9C4INC40LzQtdC50LvQuNGC0LUg0LzQuD8g
0LzQvtC70Y8sINC/0YDQvtCy0LXRgNC10YLQtSDQuCDQvNC4INC+0YLQs9C+0LLQvtGA0LXRgtC1
DQo=
