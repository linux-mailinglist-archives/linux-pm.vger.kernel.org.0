Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B02B824E753
	for <lists+linux-pm@lfdr.de>; Sat, 22 Aug 2020 14:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgHVMQw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 22 Aug 2020 08:16:52 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29119 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726920AbgHVMQv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 22 Aug 2020 08:16:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598098609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s1PhZ9//qAtXW+wBZ1G+cKJixVit0c5kcvX8lH+2smM=;
        b=RMEHyVTGCor9U8vZKExK2be91MdptBbl60VnTdp8r0x96GnPfNAl3+PszeNYWYmnmWMp8V
        wLIG/XDifdOugW18769zugOhRtFNq6keojn60i8/MsmqMS5Jgj2dOrRGKUhlrCzmLDAikV
        /DgCI7TxMK8nG9QFUOSffMOFiUalWQk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-d0lPOpulONucBFQHxX5_vg-1; Sat, 22 Aug 2020 08:16:48 -0400
X-MC-Unique: d0lPOpulONucBFQHxX5_vg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E7C91DE14;
        Sat, 22 Aug 2020 12:16:47 +0000 (UTC)
Received: from darcari.bos.csb (ovpn-113-99.rdu2.redhat.com [10.10.113.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A3C4B7B41F;
        Sat, 22 Aug 2020 12:16:46 +0000 (UTC)
Subject: Re: [PATCH] tools/power turbostat: fix output formatting for ACPI CST
 enumeration
To:     Len Brown <lenb@kernel.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200810144330.75613-1-darcari@redhat.com>
 <CAJvTdKms-sO=Qvpnhe4OjE48gXHPzDKbT0i5vK2QuDCxZTt_+Q@mail.gmail.com>
From:   David Arcari <darcari@redhat.com>
Organization: Red Hat
Message-ID: <d8f50a6a-be68-f92b-e15f-c9f70335643f@redhat.com>
Date:   Sat, 22 Aug 2020 08:16:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAJvTdKms-sO=Qvpnhe4OjE48gXHPzDKbT0i5vK2QuDCxZTt_+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Len,

Thanks for the quick turn around.  My apologies for not checking the tree before 
sending a follow-up email.

If you decide you prefer to change intel_idle - I'd be happy to do the work if 
you'd like.  Just let me know.

Thanks,

-Dave


On 8/21/20 2:23 PM, Len Brown wrote:
> Hi Dave,
> 
> I think this is fine.
> Indeed, I actually went ahead and applied it a week or so ago.
> 
> the only alternative that I can think of is actually shortening the
> ACPI C-state names in the intel_idle driver -- which is still an
> option.  It would not be the first time we have tweaked the names used
> in that driver to make tools more happy...
> 
> My apology for neglecting to send you an ACK.
> I had intended to send my queued series to the list, which would
> suffice for all the ACKs, but that send and the subsequent push got
> delayed by this and that.  So I'll try to ack as I go, so it is clear
> at any time where a patch stands.
> 
> thanks!
> 
> Len Brown, Intel Open Source Technology Center
> 

