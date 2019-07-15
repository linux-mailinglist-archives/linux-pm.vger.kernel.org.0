Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCDAC69265
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2019 16:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732173AbfGOOg1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jul 2019 10:36:27 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]:45580 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391898AbfGOOct (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jul 2019 10:32:49 -0400
Received: by mail-qk1-f174.google.com with SMTP id s22so11729894qkj.12
        for <linux-pm@vger.kernel.org>; Mon, 15 Jul 2019 07:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=MXh0ZspvhTtLSjl/YpBBNEHt0/KC9OGfnArn9dg77/8=;
        b=mjizCUklindePDtTzQUYklDtWXrSScF5E/eIuaiho6dDHG84ZVVqwsKE6FES2bLreA
         ccUQQuyAOoOHh//yasxiPHIzhqGpNsG8sEsZ7Qivo+89/8TWdAh1FYhrLNADUElrzLEn
         JaGL5IF5A7712yj7uMEFIqQ2ZT+UnaCQvO+VE4axq0bMTINOjbb9wB2Vpq7YOrE+IjwJ
         caMud/008gWQ+cy5HFRyP67mHdawgxF1ILaphdq5SEjZsUFIkhCJl3aJr9YCh6jH5zVY
         l3q8aZ6QFVumOe/l1z2o5fqdK29Tuy85kvDLzlyKQK1DyxrRImqu+70st2hUmdrNGahV
         Fk9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=MXh0ZspvhTtLSjl/YpBBNEHt0/KC9OGfnArn9dg77/8=;
        b=BbvZXS62+SngugURhmak5lP7UrUUoRHBpHFw9h4t/uC92H9jMK/WQxK0xj4ZYnNo6G
         lzUvlVgQ/Drp6+1FEFYYLOK3ogekaFK6lDK4m0cCl5vm2TALTcZ+5LW8m50tzKO/qVqc
         7Yr2o0t8nRKSqVAVSsIzm2Evp3RoGubbfS/+F2Sp8AI+2n6ytiNU7fpK6SzT3OozETsU
         lzkwxX84kLQDOSUE7D4vmN+JXtHeC3L4+MGWyedikt5MYhPCHZ3QjtR6Ap3DmWh8T7+x
         3L8CwjGkw33Ho1/nCZhpBxsSt2GzsB+vbfABZv8tX9Sti6HW0SCsukIf0L+WE9kSDbrI
         MH+Q==
X-Gm-Message-State: APjAAAVOUnEurD6ILlCpQz8RZvtHIH6BC8Tx+rrUGTfT85DGsW9Gb2Rp
        rowzl4sbSYoS8xS+LNBIBnCz9qeL
X-Google-Smtp-Source: APXvYqzqTH13AOI5H3VhDf6bupQHD8Pkw/ynnQyAOMawqipOaIRUbhN9A/UieYf1owHBlJjnZ1ZMUA==
X-Received: by 2002:a37:9844:: with SMTP id a65mr16863105qke.500.1563201167989;
        Mon, 15 Jul 2019 07:32:47 -0700 (PDT)
Received: from localhost.localdomain ([201.17.216.227])
        by smtp.gmail.com with ESMTPSA id h19sm5469589qto.3.2019.07.15.07.32.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 07:32:47 -0700 (PDT)
Date:   Mon, 15 Jul 2019 07:32:12 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Linux PM <linux-pm@vger.kernel.org>,
        Rui Zhang <rui.zhang@intel.com>
Subject: [NOTICE] Eduardo is offline during July
Message-ID: <20190715143210.GA1861@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Folks,


I just want to let you know that I am offline during July with mostly
very limited Internet access. I will return to review and collect patch
in August. Sorry for any inconvenience this may have caused.

If any urgent fixes/patches please redirect to Rui.

BR,

Eduardo Valentin
