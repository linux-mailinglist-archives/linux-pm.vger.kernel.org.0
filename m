Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E535FD17E2
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2019 20:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbfJIS4R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Oct 2019 14:56:17 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41373 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbfJIS4Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Oct 2019 14:56:16 -0400
Received: by mail-ed1-f68.google.com with SMTP id f20so3048868edv.8
        for <linux-pm@vger.kernel.org>; Wed, 09 Oct 2019 11:56:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ME4SGdezP8EuNZKcuKCFfTPKlUcPKl6rwZfU4amJBUk=;
        b=lrlbQQawNwPg7jjxNah+7CukeDtqzZPgpkPwB7EtLFlJuNmoRYZuTNBi0/DgagO3CB
         zoSKq/pjdgGOrobdD+g7fEpFSICFYuh1lqrjn2r5xgEdQ4787LGBXNS8smPYZk3d3ha9
         Ei17+bT1T57dCZ7qP1czub5y3yhEbKCW9BhWPcxgaIvYBu2V6GhW+djGj9JmLhuGZX5t
         RGDZ4818NUVDm1splPgzVNUWFJkPotglmenMjZCYiUgp+5si4xRf15iTcD0jYKT1yNna
         4F6QwtxmxrJP9CQOd+vMtXcbEnwymVwmfEOiFDFw9ZUPYSir32trB1cBif6a/hS96w0a
         oa9A==
X-Gm-Message-State: APjAAAXnW75lbrMOAid3cseMa4gqGHZkaNIMma0oTyO7VfkI/88KMcZ8
        o7EmQX3fcLTtQMOgVCep77+iozPrZaGijTd9zC2Z0A==
X-Google-Smtp-Source: APXvYqyi9hZ7+EUv1ogH09bGu3J7WFLkxjN39fKCneOb/s/VOq7c+I99nkxjpLEVhiDBpDjQQk+xmfywxExUrWXNgZE=
X-Received: by 2002:a17:906:4a8d:: with SMTP id x13mr4132553eju.317.1570647375351;
 Wed, 09 Oct 2019 11:56:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190919190912.8386-1-todd.e.brandt@linux.intel.com>
In-Reply-To: <20190919190912.8386-1-todd.e.brandt@linux.intel.com>
From:   Len Brown <lenb@kernel.org>
Date:   Wed, 9 Oct 2019 14:56:04 -0400
Message-ID: <CAJvTdKkUR1FVrfaboRB=Yan-XtQrBjr8P-6tEBffBONfdVqrUA@mail.gmail.com>
Subject: Re: [PATCH] pm-graph info added to MAINTAINERS
To:     Todd Brandt <todd.e.brandt@linux.intel.com>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, todd.e.brandt@intel.com,
        "Brown, Len" <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Reviewed-by: Len Brown <len.brown@intel.com>
